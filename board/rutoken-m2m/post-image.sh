#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

cp board/${BOARD_NAME}/config.txt ${BINARIES_DIR}/config.txt
cp board/${BOARD_NAME}/cmdline.txt ${BINARIES_DIR}/cmdline.txt

mv ${BINARIES_DIR}/zImage ${BINARIES_DIR}/kernel7.img

for arg in "$@"
do
	case "${arg}" in
		--add-pi3-miniuart-bt-overlay)
		if ! grep -qE '^dtoverlay=pi3-miniuart' "${BINARIES_DIR}/config.txt"; then
			echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
			cat << __EOF__ >> "${BINARIES_DIR}/config.txt"

# fixes rpi3 ttyAMA0 serial console
dtoverlay=pi3-miniuart-bt
__EOF__
		fi
		;;
		--add-pi3-disable-bt-overlay)
		if ! grep -qE '^dtoverlay=pi3-disable' "${BINARIES_DIR}/config.txt"; then
			echo "Adding 'dtoverlay=pi3-disable-bt' to config.txt (disables the Bluetooth device and restores UART0/ttyAMA0 to GPIOs 14 and 15)."
			cat << __EOF__ >> "${BINARIES_DIR}/config.txt"

# disables the Bluetooth device and restores UART0/ttyAMA0 to GPIOs 14 and 15
dtoverlay=pi3-disable-bt
__EOF__
		fi
		;;
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/config.txt"
		if ! grep -qE '^arm_64bit=1' "${BINARIES_DIR}/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/config.txt"

# enable 64bits support
arm_64bit=1
__EOF__
		fi

		# Enable uart console
		if ! grep -qE '^enable_uart=1' "${BINARIES_DIR}/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/config.txt"

# enable rpi3 ttyS0 serial console
enable_uart=1
__EOF__
		fi
		;;
		--gpu_mem_256=*|--gpu_mem_512=*|--gpu_mem_1024=*)
		# Set GPU memory
		gpu_mem="${arg:2}"
		sed -e "/^${gpu_mem%=*}=/s,=.*,=${gpu_mem##*=}," -i "${BINARIES_DIR}/config.txt"
		;;
	esac

done

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
