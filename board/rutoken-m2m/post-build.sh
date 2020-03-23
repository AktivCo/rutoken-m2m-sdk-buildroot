#!/bin/sh

set -u
set -e

LEGAL_INFO="${BASE_DIR}/legal-info"

# Add all licenses and sources to buildroot image
if [ -d ${LEGAL_INFO} ]; then
	mkdir -p ${TARGET_DIR}/usr/share
	cp -r ${LEGAL_INFO} ${TARGET_DIR}/usr/share
fi


# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi