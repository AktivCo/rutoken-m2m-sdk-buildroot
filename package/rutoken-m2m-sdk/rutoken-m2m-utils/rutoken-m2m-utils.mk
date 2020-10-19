################################################################################
#
# Rutoken M2M utils
#
################################################################################
RUTOKEN_M2M_UTILS_VERSION = c2adba07bdad896a6c3610c9d48073f5721edddd
RUTOKEN_M2M_UTILS_SOURCE      = m2m-utils-$(RUTOKEN_M2M_UTILS_VERSION).tar.gz
RUTOKEN_M2M_UTILS_SITE_METHOD = git
RUTOKEN_M2M_UTILS_SITE        = git@scm.aktivco.ru:rutoken-res/m2m-utils.git
RUTOKEN_M2M_UTILS_INSTALL_DIR = $(TARGET_DIR)/opt/Rutoken/m2m-utils
RUTOKEN_M2M_UTILS_API_INSTALL_DIR = $(TARGET_DIR)/opt/Rutoken/m2m-utils/include
RUTOKEN_M2M_UTILS_README_INSTALL_DIR = $(TARGET_DIR)/opt/Rutoken/m2m-utils/doc/
RUTOKEN_M2M_UTILS_LICENSE = BSD-2-Clause
RUTOKEN_M2M_UTILS_LICENSE_FILES = LICENSE

define RUTOKEN_M2M_UTILS_INSTALL_TARGET_CMDS
	mkdir -p $(RUTOKEN_M2M_UTILS_API_INSTALL_DIR)
	mkdir -p $(RUTOKEN_M2M_UTILS_README_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/rt-uart-test $(RUTOKEN_M2M_UTILS_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/rt-control $(RUTOKEN_M2M_UTILS_INSTALL_DIR)
	$(INSTALL) -D -m 0755 $(@D)/rt-run-sample $(RUTOKEN_M2M_UTILS_INSTALL_DIR)
	
	$(INSTALL) -D -m 0755 $(@D)/include/rt-api $(RUTOKEN_M2M_UTILS_API_INSTALL_DIR)

	$(INSTALL) -D -m 0644 $(@D)/README.md $(RUTOKEN_M2M_UTILS_README_INSTALL_DIR)
	$(INSTALL) -D -m 0644 $(@D)/README_RUS.md $(RUTOKEN_M2M_UTILS_README_INSTALL_DIR)
endef

$(eval $(generic-package))