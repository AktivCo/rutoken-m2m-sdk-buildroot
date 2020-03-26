################################################################################
#
# rtuart
#
################################################################################

RTUART_VERSION     = v1.0.0
RTUART_SOURCE      = rtuart-$(RTUART_VERSION).tar.gz
RTUART_SITE_METHOD = git
RTUART_SITE        = git@scm.aktivco.ru:rutoken-res/m2m-ecp-uart.git
RTUART_INSTALL_TARGET = YES
RTUART_LICENSE = BSD-2-Clause
RTUART_LICENSE_FILES = LICENSE

RTUART_CONF_OPTS = -DRTUART_SERIAL_PORT="/dev/ttyAMA0"

ifeq ($(BR2_PACKAGE_RUTOKEN_UTILS),y)
	RTUART_CONF_OPTS += -DTRANSPORT_TEST_INSTALL_PATH="/opt/Rutoken/bin"
endif

$(eval $(cmake-package))
