################################################################################
#
# Samples from Rutoken SDK of interacting with Rutoken smartcards using OpenSSL 
# API and rtengine
#
################################################################################
RUTOKEN_SDK_RTENGINE_SAMPLES_VERSION = 180919-80c054
RUTOKEN_SDK_RTENGINE_SAMPLES_SOURCE_BASENAME = sdk-$(RUTOKEN_SDK_RTENGINE_SAMPLES_VERSION)
RUTOKEN_SDK_RTENGINE_SAMPLES_SOURCE = $(RUTOKEN_SDK_RTENGINE_SAMPLES_SOURCE_BASENAME).zip
RUTOKEN_SDK_RTENGINE_SAMPLES_NAME = rutoken-rtengine-samples
RUTOKEN_SDK_RTENGINE_SAMPLES_SITE	= https://download.rutoken.ru/Rutoken/SDK/archive
RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_DIR = $(TARGET_DIR)/opt/Rutoken/workspace/sdk/rtengine
RUTOKEN_OPENSSL_INSTALL_DIR = $(TARGET_DIR)/opt/Rutoken/workspace/sdk/openssl
RUTOKEN_SDK_RTENGINE_SAMPLES_LICENSE = CJSC-Aktiv-Soft-commercial-license
RUTOKEN_SDK_RTENGINE_SAMPLES_LICENSE_FILES = sdk/License_Agreement.pdf sdk/pkcs11/LICENSE_OPENSSL sdk/pkcs11/README.txt

define RUTOKEN_SDK_RTENGINE_SAMPLES_EXTRACT_CMDS
	unzip $(DL_DIR)/$(RUTOKEN_SDK_RTENGINE_SAMPLES_NAME)/$(RUTOKEN_SDK_RTENGINE_SAMPLES_SOURCE) -d $(@D)
endef

define RUTOKEN_SDK_RTENGINE_SAMPLES_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/sdk/openssl/rtengine/samples
endef

define RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_TARGET_CMDS
	mkdir -p $(RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_DIR)
	mkdir -p $(RUTOKEN_OPENSSL_INSTALL_DIR)

	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/openssl-shared-1.1/linux_glibc-armv7hf/lib/libcrypto.so $(RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/openssl-shared-1.1/linux_glibc-armv7hf/lib/libssl.so $(RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/rtengine/bin/linux_glibc-armv7hf/lib/librtengine.so $(RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_DIR)
	cp -R $(@D)/sdk/openssl/rtengine/samples/out/linux_glibc-armv7hf-release/* $(RUTOKEN_SDK_RTENGINE_SAMPLES_INSTALL_DIR)

	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/openssl-tool-1.1/linux_glibc-armv7hf/libcrypto.so $(RUTOKEN_OPENSSL_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/openssl-tool-1.1/linux_glibc-armv7hf/libssl.so $(RUTOKEN_OPENSSL_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/openssl-tool-1.1/linux_glibc-armv7hf/openssl $(RUTOKEN_OPENSSL_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/sdk/openssl/rtengine/bin/linux_glibc-armv7hf/lib/librtengine.so $(RUTOKEN_OPENSSL_INSTALL_DIR)

	cp -R $(@D)/sdk/openssl/rtengine/samples/tool/demoCA $(RUTOKEN_OPENSSL_INSTALL_DIR)
	find $(RUTOKEN_OPENSSL_INSTALL_DIR)/demoCA -type d -exec chmod 0755 {} \;
	find $(RUTOKEN_OPENSSL_INSTALL_DIR)/demoCA -type f -exec chmod 0644 {} \;

	$(INSTALL) -m 0644 $(@D)/sdk/openssl/rtengine/samples/tool/README.txt $(RUTOKEN_OPENSSL_INSTALL_DIR)
	$(INSTALL) -m 0644 $(@D)/sdk/openssl/rtengine/samples/tool/openssl.cnf $(RUTOKEN_OPENSSL_INSTALL_DIR)
endef

$(eval $(generic-package))