#!/bin/bash

RET_CODE=0

OPENSSL_PATH="/home/${SUDO_USER}/sdk/openssl"

RTENGINE_SAMPLES_PATH="/home/${SUDO_USER}/sdk/rtengine"

TMP_TEST_DIR="/tmp/$(head -c 5 /dev/urandom | base32)"

fail(){
    echo "[FAILED] $1"
    ((RET_CODE=RET_CODE+1))
}

init(){
    pushd `pwd` > /dev/null 2>&1

    mkdir $TMP_TEST_DIR
    chown ${SUDO_USER} $TMP_TEST_DIR
    cp -p /home/${SUDO_USER}/sdk/rtengine/test_* $TMP_TEST_DIR
    cd $TMP_TEST_DIR
}

cleanup(){
    popd > /dev/null 2>&1

    rm -r $TMP_TEST_DIR

    if [ $RET_CODE -ne 0 ]; then
        echo "Failed! Number of errors: $RET_CODE"
        exit 1
    fi

    echo "Succeed!"
}

ctrl_c() {
    exit
}

check_rtengine_samples_presence(){
    echo "Checking rtengine samples presence..."

    RTENGINE_SAMPLES_LIST=("HardwareTokenPreparation"
                        "HardwareCreateCSR"
                        "HardwareEncryptCMS"
                        "HardwareDecryptCMS"
                        "HardwareDerive"
                        "HardwareKeyWrap"
                        "HardwareKeyUnwrap"
                        "HardwareSign"
                        "HardwareSignCMS"
                        "HardwareVerify"
                        "HardwareVerifyCMS"
                        "HardwareKeyDeleting"
                        "SoftwareKeyGeneration"
                        "SoftwareKeyWrap"
                        "SoftwareKeyUnwrap"
                        "SoftwareDerive"
                        "SoftwareSign"
                        "SoftwareVerify"
                        "SoftwareCreateCSR"
                        "SoftwareEncryptCMS"
                        "SoftwareDecryptCMS"
                        "SoftwareSignCMS"
                        "SoftwareVerifyCMS")

    for RTENGINE_SAMPLE in "${RTENGINE_SAMPLES_LIST[@]}"; do
        if [ ! -f "$RTENGINE_SAMPLES_PATH/$RTENGINE_SAMPLE" ]; then
            fail "rtengine samples: sample $RTENGINE_SAMPLE not found!"
        fi
    done

    for FILE_PATH in $RTENGINE_SAMPLES_PATH/*; do
        FILE_NAME=`basename $FILE_PATH`
        if [[ ! "${RTENGINE_SAMPLES_LIST[@]}" =~ "$FILE_NAME" ]] && `file $RTENGINE_SAMPLES_PATH/$FILE_NAME | grep -q "LSB executable"`; then
            fail "Found additional executable $FILE_NAME in rtengine samples directory. Samples list should be updated."
        fi
    done
}

run_sample(){
    DEVICE=$1
    SAMPLE=$2

    if ! `rt-run-sample -d $DEVICE -p "$RTENGINE_SAMPLES_PATH/$SAMPLE" | grep -q "Sample has been completed successfully"`; then
        fail "PKCS#11 samples: sample $SAMPLE failed!"
    fi
}

create_cert_for_software_cms(){
    OPENSSL_CONF=$OPENSSL_PATH/openssl.cnf $OPENSSL_PATH/openssl x509 -engine rtengine \
    -req -in csr.pem -CA "$RTENGINE_SAMPLES_PATH/test_trusted_ca.cer" -CAkey "$RTENGINE_SAMPLES_PATH/test_ca_key.pem" \
    -CAcreateserial -days 500 -outform PEM -out test_cert.cer > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        fail "openssl: failed to generate certificate!"
    fi
}

run_rtengine_samples(){
    RTENGINE_SAMPLES_LAUNCH_ORDER=("HardwareTokenPreparation"
                                "SoftwareKeyGeneration"
                                "HardwareCreateCSR"
                                "HardwareEncryptCMS"
                                "HardwareDecryptCMS"
                                "HardwareKeyWrap"
                                "HardwareKeyUnwrap"
                                "HardwareSign"
                                "HardwareSignCMS"
                                "HardwareVerify"
                                "HardwareVerifyCMS"
                                "HardwareDerive"
                                "SoftwareDerive"
                                "SoftwareKeyWrap"
                                "SoftwareKeyUnwrap"
                                "SoftwareSign"
                                "SoftwareVerify"
                                "SoftwareCreateCSR"
                                "SoftwareEncryptCMS"
                                "SoftwareDecryptCMS"
                                "SoftwareSignCMS"
                                "SoftwareVerifyCMS"
                                "HardwareKeyDeleting")

    TESTING_CASES=("2010" "4010" "21xx")

    for CASE in "${TESTING_CASES[@]}"; do
        echo "Running rtengine samples on device $CASE..."

        for RTENGINE_SAMPLE in "${RTENGINE_SAMPLES_LAUNCH_ORDER[@]}"; do
            echo "Running rtengine sample $RTENGINE_SAMPLE..."

            case $RTENGINE_SAMPLE in
                SoftwareCreateCSR) 
                    run_sample $CASE $RTENGINE_SAMPLE
                    create_cert_for_software_cms
                ;;
                *)
                    run_sample $CASE $RTENGINE_SAMPLE
                ;;
            esac
        done

        echo ""
    done
}

user_id=$(id -u)
if [ "$user_id" -ne 0 ]; then
	echo "run as root"
	exit 1
fi

trap cleanup EXIT
trap ctrl_c SIGINT

init

check_rtengine_samples_presence
run_rtengine_samples