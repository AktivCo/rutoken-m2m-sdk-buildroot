################################################################################
#
# opensc
#
################################################################################
OPENSC_VERSION = 0.20.0
OPENSC_SOURCE = opensc-$(OPENSC_VERSION).tar.gz
OPENSC_SITE_METHOD	= wget
OPENSC_SITE	= https://github.com/OpenSC/OpenSC/releases/download/0.20.0
OPENSC_DEPENDENCIES = pcsc-lite openssl
OPENSC_INSTALL_TARGET = YES
OPENSC_AUTORECONF = YES
OPENSC_LICENSE = GPL-2.1
OPENSC_LICENSE_FILES = COPYING

$(eval $(autotools-package))
