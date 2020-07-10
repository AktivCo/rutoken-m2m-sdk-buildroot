################################################################################
#
# rtuartscreader
#
################################################################################

RTUARTSCREADER_VERSION     = v1.0.0
RTUARTSCREADER_SOURCE      = rtuartscreader-$(RTUARTSCREADER_VERSION).tar.gz
RTUARTSCREADER_SITE_METHOD = git
RTUARTSCREADER_SITE        = git@scm.aktivco.ru:rutoken-res/m2m-rtuartscreader.git
RTUARTSCREADER_INSTALL_TARGET = YES
RTUARTSCREADER_LICENSE = BSD-2-Clause, BSD-3-Clause (PCSC headers, googletest), BSL-1.0 (boost-preprocessor), Unlicense (pigpio)
RTUARTSCREADER_LICENSE_FILES = LICENSE

RTUARTSCREADER_CONF_OPTS = -DRTUARTSCREADER_SERIAL_PORT="/dev/ttyAMA0" -DRTUARTSCREADER_BUILD_UNITTESTS=OFF

$(eval $(cmake-package))
