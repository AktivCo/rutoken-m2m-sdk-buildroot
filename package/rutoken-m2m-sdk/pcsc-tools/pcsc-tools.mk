################################################################################
#
# pcsc-tools
#
################################################################################

PCSC_TOOLS_VERSION = 1.5.5
PCSC_TOOLS_SOURCE = pcsc-tools-$(PCSC_TOOLS_VERSION).tar.gz
PCSC_TOOLS_SITE_METHOD	= wget
PCSC_TOOLS_SITE	= https://github.com/LudovicRousseau/pcsc-tools/archive
PCSC_TOOLS_DEPENDENCIES = pcsc-lite host-pkgconf
PCSC_TOOLS_INSTALL_TARGET = YES
PCSC_TOOLS_AUTORECONF = YES
PCSC_TOOLS_LICENSE = GPL-2.0
PCSC_TOOLS_LICENSE_FILES = LICENCE

$(eval $(autotools-package))
