#!/bin/bash

RET_CODE=0

PATH_REGEX='("/[[:print:]]*"|/[[:graph:]]*)[[:blank:]]'

# Get default pcscd paths
PCSCD_DRIVER_DEFAULT_DIR=`pcscd --version | tr '\n' ' ' |  grep -oE "usbdropdir=${PATH_REGEX}" | cut -d ' ' -f 1 | cut -d '=' -f 2`
PCSCD_CFG_DEFAULT_DIR=`pcscd --version | tr '\n' ' ' |  grep -oE "configdir=${PATH_REGEX}" | cut -d ' ' -f 1 | cut -d '=' -f 2`

TMP_PCSC_LOG_FILE="/tmp/$(head -c 5 /dev/urandom | base32)"

fail(){
    echo "[FAILED] $1"
    ((RET_CODE=RET_CODE+1))
}

init(){
    pushd `pwd` > /dev/null 2>&1

    touch $TMP_PCSC_LOG_FILE
    chown ${SUDO_USER} $TMP_PCSC_LOG_FILE
}

cleanup(){
    popd > /dev/null 2>&1

    rm $TMP_PCSC_LOG_FILE

    if [ $RET_CODE -ne 0 ]; then
        echo "Failed! Number of errors: $RET_CODE"
        exit 1
    fi

    echo "Succeed!"
}

ctrl_c() {
    exit
}

check_buildroot_packets(){
    echo "Checking buildroot packets..."

    BUILDROOT_PACKETS=("libpcsclite"
                        "pcscd"
                        "pcsc-spy"
                        "pcsc_scan"
                        "opensc-tool"
                        "opensc-explorer"
                        "openssl"
                        "pkcs11-tool"
                        "pkcs15-tool"
                        "librtpkcs11ecp"
                        "librtengine"
                        "python"
                        "rt-control"
                        "rt-run-sample"
                        "rt-uart-test")

    for PACKET in "${BUILDROOT_PACKETS[@]}"; do
        if ! `whereis $PACKET | tr '\n' ' ' | grep -qE "${PATH_REGEX}"`; then
            fail "buildroot: packet $PACKET not found!"
        fi
    done
}

check_buildroot_sources(){
    echo "Checking buildroot sources..."

    BUILDROOT_SOURCES_DIR="/usr/share/legal-info"

    if [ ! -d $BUILDROOT_SOURCES_DIR ]; then
        fail "buildroot: sources not found!"
    fi
}

check_sdk_openssl(){
    echo "Checking sdk/openssl..."

    OPENSSL_PATH="/home/${SUDO_USER}/sdk/openssl"

    if [ ! -f "$OPENSSL_PATH/openssl" ] || [ ! -f "$OPENSSL_PATH/openssl.cnf" ]; then
        fail "openssl: not found!"
    fi

    if ! `OPENSSL_CONF=$OPENSSL_PATH/openssl.cnf $OPENSSL_PATH/openssl engine | grep -q rtengine`; then
        fail "openssl: rtengine not found!"
    fi
}

check_ccid(){
    echo "Checking CCID presence..."

    if [ ! -f "$PCSCD_DRIVER_DEFAULT_DIR/ifd-ccid.bundle/Contents/Linux/libccid.so" ]; then
        fail "CCID: libccid.so not found!"
    fi

    if [ ! -f "$PCSCD_DRIVER_DEFAULT_DIR/ifd-ccid.bundle/Contents/Info.plist" ]; then
        fail "CCID: Info.plist not found!"
    fi
}

check_serial_driver(){
    SERIAL_DRIVER_NAME="lib$1"

    echo "Checking $SERIAL_DRIVER_NAME presence..."

    SERIAL_DRIVER_DIR="$PCSCD_DRIVER_DEFAULT_DIR/serial"
    SERIAL_DRIVER_CFG_PATH="$PCSCD_CFG_DEFAULT_DIR/$SERIAL_DRIVER_NAME"

    if [ ! -f $SERIAL_DRIVER_CFG_PATH ]; then
        SERIAL_DRIVER_CFG_PATH="$PCSCD_CFG_DEFAULT_DIR/.$SERIAL_DRIVER_NAME"
    fi

    SERIAL_DRIVER_SYMLINK="$SERIAL_DRIVER_DIR/$SERIAL_DRIVER_NAME.so"
    SERIAL_DRIVER_SYMLINK_2="$SERIAL_DRIVER_DIR/$(readlink $SERIAL_DRIVER_SYMLINK)"
    SERIAL_DRIVER_SO="$SERIAL_DRIVER_DIR/$(readlink $SERIAL_DRIVER_SYMLINK_2)"

    if [ ! -f "$SERIAL_DRIVER_SYMLINK" ] || [ ! -f "$SERIAL_DRIVER_SYMLINK_2" ] || [ ! -f "$SERIAL_DRIVER_SO" ]; then
        fail "$SERIAL_DRIVER_NAME: $SERIAL_DRIVER_NAME not found!"
    fi

    if [ ! -f $SERIAL_DRIVER_CFG_PATH ]; then
        fail "$SERIAL_DRIVER_NAME: $SERIAL_DRIVER_NAME config file not found!"
    fi

    echo "Checking $SERIAL_DRIVER_NAME config..."

    SERIAL_DRIVER_DEVICENAME=`cat $SERIAL_DRIVER_CFG_PATH | tr '\n' ' ' | grep -oE "DEVICENAME[[:blank:]]+${PATH_REGEX}" | tr -s ' ' | cut -d ' ' -f 2`
    SERIAL_DRIVER_LIBPATH=`cat $SERIAL_DRIVER_CFG_PATH | tr '\n' ' ' | grep -oE "LIBPATH[[:blank:]]+${PATH_REGEX}" | tr -s ' ' | cut -d ' ' -f 2`

    if [ ${SERIAL_DRIVER_DEVICENAME} != "/dev/ttyAMA0" ]; then
        fail "$SERIAL_DRIVER_NAME: wrong DEVICENAME!"
    fi

    if [ ${SERIAL_DRIVER_LIBPATH} != "$SERIAL_DRIVER_SYMLINK" ]; then
        fail "$SERIAL_DRIVER_NAME: wrong LIBPATH!"
    fi
}

run_rtuart_test(){
    echo "Running rt-uart-test..."

    rt-control -s 4010 > /dev/null 2>&1
    if ! `rt-uart-test -f | grep -q "Test Ok"`; then
        fail "rt-uart-test: test failed!"
    fi
}

check_rtcontrol(){
    echo "Checking rt-control devices deactivation..."

    rt-control -s > /dev/null 2>&1
    timeout 1 pcsc_scan -r 1> $TMP_PCSC_LOG_FILE 2>/dev/null
    if ! `grep -q "Waiting for the first reader..." $TMP_PCSC_LOG_FILE`; then
        fail "rt-control: not all devices are disabled"
    fi

    echo "Checking rt-control device activation..."

    declare -A RT_DEVICES
    RT_DEVICES["2010"]="Aktiv Rutoken ECP 00 00"
    RT_DEVICES["4010"]="Aktiv Rutoken ECP B 00 00"
    RT_DEVICES["21xx"]="Aktiv Rutoken UART SC Reader 00 00"

    for DEVICE in "${!RT_DEVICES[@]}"; do
        rt-control -s ${DEVICE} > /dev/null 2>&1
        timeout 1 pcsc_scan -r 1> $TMP_PCSC_LOG_FILE 2>/dev/null
        if ! `grep -q "${RT_DEVICES[$DEVICE]}" $TMP_PCSC_LOG_FILE`; then
            fail "rt-control: wrong device activated while activating $DEVICE"
        fi
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

check_buildroot_packets
check_buildroot_sources
check_sdk_openssl
check_ccid
check_serial_driver "rtuart"
check_serial_driver "rtuartscreader" 
check_rtcontrol
run_rtuart_test