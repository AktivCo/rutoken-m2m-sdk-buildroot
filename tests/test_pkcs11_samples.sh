#!/bin/bash

RET_CODE=0

OPENSSL_PATH="/home/${SUDO_USER}/sdk/openssl"

PKCS_SAMPLES_PATH="/home/${SUDO_USER}/sdk/pkcs11"

TMP_TEST_DIR="/tmp/$(head -c 5 /dev/urandom | base32)"

RUNNING_TESTS_ON_MICRON=true

usage(){
	echo "Usage: ./test_pkcs11_samples.sh [command]"
	echo ""
	echo "Commands:"
	echo "  -m, --micron"
	echo "    Disable running 512-bit GOST samples and Journal samples on device 21xx"
	echo ""
	echo "  -h, --help"
	echo "    Show this message."
}

fail(){
    echo "[FAILED] $1"
    ((RET_CODE=RET_CODE+1))
}

init(){
    pushd `pwd` > /dev/null 2>&1

    mkdir $TMP_TEST_DIR
    chown ${SUDO_USER} $TMP_TEST_DIR
    cd $TMP_TEST_DIR
}

cleanup(){
    popd > /dev/null 2>&1

    rm -r $TMP_TEST_DIR

    if [ $RET_CODE -ne 0 ]; then
        echo "Failed! Number of errors: $RET_CODE"
        echo "Long GOST and Journal samples may fail on Micron based smartcards." 
        echo "Use -m, --micron flag to disable these tests on Micron."
        exit 1
    fi

    echo "Succeed!"
}

ctrl_c() {
    exit
}
 
check_pkcs11_samples_presence(){
    echo "Checking PKCS#11 samples presence..."

    PKCS_SAMPLES_LIST=("Info"
                    "InitToken"
                    "GeneralPurpose"
                    "CreateGOST28147-89"
                    "CreateGOST34.10-2001"
                    "CreateGOST34.10-2012-256"
                    "CreateGOST34.10-2012-512"
                    "CreateRSA"
                    "SignGOST34.10-2001WithInternalHash"
                    "SignGOST34.10-2012-256WithInternalHash"
                    "SignGOST34.10-2012-512WithInternalHash"
                    "EncDecGOST28147-89"
                    "EncDecGOST28147-89-CBC"
                    "EncDecGOST28147-89-Stream"
                    "EncDecRSA"
                    "SignVerifyGOST28147-89-MAC"
                    "SignVerifyGOST34.11-94-HMAC"
                    "SignVerifyGOST34.10-2001"
                    "SignVerifyGOST34.10-2012-256"
                    "SignVerifyGOST34.10-2012-512"
                    "SignVerifyRSA"
                    "VKO-GOST34.10-2001"
                    "VKO-GOST34.10-2012-256"
                    "VKO-GOST34.10-2012-512"
                    "HashGOST34.11-94"
                    "HashGOST34.11-2012-512"
                    "Journal"
                    "JournalParse"
                    "DeleteGOST28147-89"
                    "DeleteGOST34.10-2001"
                    "DeleteGOST34.10-2012-256"
                    "DeleteGOST34.10-2012-512"
                    "DeleteRSA"
                    "CreateCSR-PKCS10-GOST34.10-2001"
                    "CreateCSR-PKCS10-GOST34.10-2012-256"
                    "CreateCSR-PKCS10-GOST34.10-2012-512"
                    "ImportCertificate-GOST34.10-2001"
                    "ImportCertificate-GOST34.10-2012-256"
                    "ImportCertificate-GOST34.10-2012-512"
                    "GetCertificateInfo-GOST34.10-2001"
                    "GetCertificateInfo-GOST34.10-2012-256"
                    "GetCertificateInfo-GOST34.10-2012-512"
                    "SignPKCS7-GOST34.10-2001"
                    "SignPKCS7-GOST34.10-2012-256"
                    "SignPKCS7-GOST34.10-2012-512"
                    "SignPKCS7Detached-GOST34.10-2001"
                    "VerifyPKCS7"
                    "VerifyPKCS7Detached"
                    "DeleteObjects-GOST34.10-2001"
                    "DeleteObjects-GOST34.10-2012-256"
                    "DeleteObjects-GOST34.10-2012-512"
                    "WaitForSlotEvent")

    for PKCS_SAMPLE in "${PKCS_SAMPLES_LIST[@]}"; do
        if [ ! -f "$PKCS_SAMPLES_PATH/$PKCS_SAMPLE" ]; then
            fail "PKCS#11 samples: sample $PKCS_SAMPLE not found!"
        fi
    done

    for FILE_PATH in $PKCS_SAMPLES_PATH/*; do
        FILE_NAME=`basename $FILE_PATH`
        if [[ ! "${PKCS_SAMPLES_LIST[@]}" =~ "$FILE_NAME" ]] && `file $PKCS_SAMPLES_PATH/$FILE_NAME | grep -q "LSB executable"`; then
            fail "Found additional executable $FILE_NAME in PKCS#11s samples directory. Samples list should be updated."
        fi
    done
}

run_sample(){
    DEVICE=$1
    SAMPLE=$2

    if ! `rt-run-sample -d $DEVICE -p "$PKCS_SAMPLES_PATH/$SAMPLE" | grep -q "Sample has been completed successfully"`; then
        fail "PKCS#11 samples: sample $SAMPLE failed!"
    fi
}

create_cert_for_import_sample(){
    SAMPLE_NAME=$1
    GOST_VERSION=`echo $SAMPLE_NAME | grep -oE "20.*"`

    OPENSSL_CONF=$OPENSSL_PATH/openssl.cnf $OPENSSL_PATH/openssl x509 -engine rtengine \
                -req -in req_$GOST_VERSION.pem -CA $OPENSSL_PATH/demoCA/cacert.pem -CAkey $OPENSSL_PATH/demoCA/private/cakey.pem \
                -CAcreateserial -days 500 -outform der -out cert_$GOST_VERSION.cer > /dev/null 2>&1

    # Samples need CA_cert in DER encoding
    OPENSSL_CONF=$OPENSSL_PATH/openssl.cnf $OPENSSL_PATH/openssl x509 -in $OPENSSL_PATH/demoCA/cacert.pem -inform PEM -outform der -out CA_cert.cer

    if [ $? -ne 0 ]; then
        fail "PKCS#11 samples: failed to create certificate for sample $SAMPLE_NAME!"
    fi
}

run_create_csr_sample(){
    SAMPLE_NAME=$1
    DEVICE_NAME=$2
    GOST_VERSION=`echo $SAMPLE_NAME | grep -oE "20.*"`
    rt-run-sample -d $DEVICE_NAME -p "$PKCS_SAMPLES_PATH/$SAMPLE_NAME" | \
    sed -ne '/-BEGIN NEW CERTIFICATE REQUEST-/,/-END NEW CERTIFICATE REQUEST-/p' > req_$GOST_VERSION.pem

    if [ ! -s req_$GOST_VERSION.pem ]; then
        fail "PKCS#11 samples: failed to create CSR in sample $SAMPLE_NAME!"
    fi
}

run_pkcs11_samples(){
    PKCS_SAMPLES_LAUNCH_ORDER=("Info"
                    "InitToken"
                    "GeneralPurpose"
                    "CreateGOST28147-89"
                    "CreateGOST34.10-2001"
                    "CreateGOST34.10-2012-256"
                    "CreateGOST34.10-2012-512"
                    "CreateRSA"
                    "SignGOST34.10-2001WithInternalHash"
                    "SignGOST34.10-2012-256WithInternalHash"
                    "SignGOST34.10-2012-512WithInternalHash"
                    "EncDecGOST28147-89"
                    "EncDecGOST28147-89-CBC"
                    "EncDecGOST28147-89-Stream"
                    "EncDecRSA"
                    "SignVerifyGOST28147-89-MAC"
                    "SignVerifyGOST34.11-94-HMAC"
                    "SignVerifyGOST34.10-2001"
                    "SignVerifyGOST34.10-2012-256"
                    "SignVerifyGOST34.10-2012-512"
                    "SignVerifyRSA"
                    "VKO-GOST34.10-2001"
                    "VKO-GOST34.10-2012-256"
                    "VKO-GOST34.10-2012-512"
                    "HashGOST34.11-94"
                    "HashGOST34.11-2012-512"
                    "ManageFlash"
                    "Journal"
                    "JournalParse"
                    "DeleteGOST28147-89"
                    "DeleteGOST34.10-2001"
                    "DeleteGOST34.10-2012-256"
                    "DeleteGOST34.10-2012-512"
                    "DeleteRSA"
                    "CreateCSR-PKCS10-GOST34.10-2001"
                    "CreateCSR-PKCS10-GOST34.10-2012-256"
                    "CreateCSR-PKCS10-GOST34.10-2012-512"
                    "ImportCertificate-GOST34.10-2001"
                    "ImportCertificate-GOST34.10-2012-256"
                    "ImportCertificate-GOST34.10-2012-512"
                    "GetCertificateInfo-GOST34.10-2001"
                    "GetCertificateInfo-GOST34.10-2012-256"
                    "GetCertificateInfo-GOST34.10-2012-512"
                    "SignPKCS7-GOST34.10-2001"
                    "SignPKCS7-GOST34.10-2012-256"
                    "SignPKCS7-GOST34.10-2012-512"
                    "SignPKCS7Detached-GOST34.10-2001"
                    "DeleteObjects-GOST34.10-2001"
                    "DeleteObjects-GOST34.10-2012-256"
                    "DeleteObjects-GOST34.10-2012-512")

    TESTING_CASES=("2010" "4010" "21xx")

    for CASE in "${TESTING_CASES[@]}"; do
        echo "Running PKCS#11 samples on device $CASE..."

        for PKCS_SAMPLE in "${PKCS_SAMPLES_LAUNCH_ORDER[@]}"; do
            if [[ $PKCS_SAMPLE =~ 512|Journal ]] && ! $RUNNING_TESTS_ON_MICRON && [ $CASE == "21xx" ]; then
                continue
            fi

            echo "Running PKCS#11 sample $PKCS_SAMPLE..."

            case $PKCS_SAMPLE in
                CreateCSR*)
                    run_create_csr_sample $PKCS_SAMPLE $CASE
                ;;
                ImportCertificate*) 
                    # Will always be successful if appropriate certificate exists
                    create_cert_for_import_sample $PKCS_SAMPLE 

                    run_sample $CASE $PKCS_SAMPLE
                ;;
                *)
                    run_sample $CASE $PKCS_SAMPLE

                    if [[ $SAMPLE =~ "SignPKCS7-" ]]; then
                        echo "Running PKCS#11 sample VerifyPKCS7..."

                        run_sample $CASE "VerifyPKCS7"
                    fi

                    if [[ $SAMPLE =~ "SignPKCS7Detached" ]]; then
                        echo "Running PKCS#11 sample VerifyPKCS7Detached..."

                        run_sample $CASE "VerifyPKCS7Detached"
                    fi
                ;;
            esac
        done

        echo ""
    done
}

case $1 in
	-m | --micron)
		RUNNING_TESTS_ON_MICRON=false
	;;
	-h | --help)
		usage
		exit 0
	;;
esac

user_id=$(id -u)
if [ "$user_id" -ne 0 ]; then
	echo "run as root"
	exit 1
fi

trap cleanup EXIT
trap ctrl_c SIGINT

init

check_pkcs11_samples_presence
run_pkcs11_samples