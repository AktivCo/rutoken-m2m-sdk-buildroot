################################################################################
#
# Rutoken SDK PKCS#11 samples
#
################################################################################
RUTOKEN_SDK_PKCS11_SAMPLES_VERSION = 180919-80c054
RUTOKEN_SDK_PKCS11_SAMPLES_SOURCE_BASENAME = sdk-$(RUTOKEN_SDK_PKCS11_SAMPLES_VERSION)
RUTOKEN_SDK_PKCS11_SAMPLES_SOURCE = $(RUTOKEN_SDK_PKCS11_SAMPLES_SOURCE_BASENAME).zip
RUTOKEN_SDK_PKCS11_SAMPLES_NAME = rutoken-pkcs11-samples
RUTOKEN_SDK_PKCS11_SAMPLES_SITE	= https://download.rutoken.ru/Rutoken/SDK/archive
RUTOKEN_SDK_PKCS11_SAMPLES_INSTALL_DIR = $(TARGET_DIR)/opt/Rutoken/workspace/sdk/pkcs11
RUTOKEN_SDK_PKCS11_SAMPLES_LICENSE = CJSC-Aktiv-Soft-commercial-license
RUTOKEN_SDK_PKCS11_SAMPLES_LICENSE_FILES = sdk/License_Agreement.pdf sdk/pkcs11/LICENSE_OPENSSL sdk/pkcs11/README.txt

define RUTOKEN_SDK_PKCS11_SAMPLES_EXTRACT_CMDS
	unzip $(DL_DIR)/$(RUTOKEN_SDK_PKCS11_SAMPLES_NAME)/$(RUTOKEN_SDK_PKCS11_SAMPLES_SOURCE) -d $(@D)
endef

define RUTOKEN_SDK_PKCS11_SAMPLES_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/sdk/pkcs11/samples/Standard
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/sdk/pkcs11/samples/Extended
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/sdk/pkcs11/samples/PKIExtensions
endef

define RUTOKEN_SDK_PKCS11_SAMPLES_INSTALL_TARGET_CMDS
	mkdir -p $(RUTOKEN_SDK_PKCS11_SAMPLES_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/sdk/pkcs11/pkcs11ecp-samples-linux_glibc-armv7hf/librtpkcs11ecp.so $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/sdk/pkcs11/util/pkcs11-spy/lib/linux_glibc-armv7el/librtpkcs11-spy.so $(TARGET_DIR)/usr/lib
	cp -R $(@D)/sdk/pkcs11/pkcs11ecp-samples-linux_glibc-armv7hf/* $(RUTOKEN_SDK_PKCS11_SAMPLES_INSTALL_DIR)
	chmod -R 0755 $(RUTOKEN_SDK_PKCS11_SAMPLES_INSTALL_DIR)
endef

$(eval $(generic-package))
