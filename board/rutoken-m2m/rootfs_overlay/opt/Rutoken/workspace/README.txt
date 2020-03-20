Rutoken M2M SDK

I. General description

Rutoken M2M SDK consists of Rutoken 4990 demonstration board, connected to the Raspberry Pi 2 module. It comes with a preconfigured Linux operating system with preinstalled smartcard management software and samples to interact with embedded Rutoken smartcard modules residing in the demonstration board. 

II. Embedded modules

Three embedded modules are residing in Rutoken 4990 demonstration board:
    1. Rutoken 2010
        The SoC module with the USB interface used for communication. USB pins are wired to external USB port marked as "USB 2010" on the demo board. To access Rutoken 2010  from within the operating system you need to link "USB 2010" port with any USB port on Raspberry PI 2 using a USB cable.
    2. Rutoken 4010
        The SOM module with the UART interface used for communication. It is connected to Raspberry Pi 2 using GPIO pins.
    3. MicroSIM reader
        The module for hosting Rutoken 2151 or Rutoken 2100 smartcards. The module has no own chip, so cards inserted are expected to be controlled by the software driver on Raspberry Pi 2. Not supported in the current version of Rutoken M2M SDK.

Full description of embedded modules is available at https://www.rutoken.ru/products/all/rutoken-m2m/.

III. Special software

The operating system installed contains additional system software and a bunch of general-purpose packages for smartcard interaction. The system software is represented by pcsclite package, that facilitates PC/SC interface for applications. It uses CCID driver for interaction with Rutoken 2010 and rtuart driver to interact with Rutoken 4010. General-purpose software packages OpenSC, pcsc-tools are also installed. Rutoken library librtpkcs11ecp.so facilitates third-party applications to interact with connected smartcards using PKCS#11 interface.

IV. Rutoken SDK Samples

`sdk` directory residing in user home directory contains compiled Rutoken SDK samples, that perform typical tasks on smartcards using PKCS#11 and OpenSSL interface. The source code of the samples is available in Rutoken SDK: https://www.rutoken.ru/developers/sdk/.

V. M2M utilities

The distribution is equipped with special utilities to provide a better user experience.
    1. rt-control utility is used to control the state of the physical connection of smartcards hosted on the demo board and to control the smartcard-aware middleware. It can power on/power off smartcards, start, stop and restart pcscd, enable and disable logging of pcscd and smartcard drivers. It also displays the current status of controlled entities.
    2. rt-run-sample utility controls logging of PCSC calls using pcsc-spy for the application started. It also allows to power on/power off selected smartcards for the application started.
    3. rt-uart-test is a wrapper utility over rtuart_transport_test from rtuart package. It either checks the runtime environment to be acceptable to run the test or forces the change of runtime environment so the test could be started.

Run utilities with `-h` option to see the help message. Also see /opt/Rutoken/m2m-utils/doc/README.md for more information.

VI. Legal information

The distribution you are using is built using the Buildroot project. The distribution contains open-source software (bootloaders, kernel, libraries, tools), released under various licenses. The buildroot itself is released under GNU General Public License, version 2. The sources used to create this distribution resides in the separate partition of the same SD card the operating system is running from. By default, this partition is mounted to `/buildroot` directory. The sources of the software packages composing the distribution and corresponding license information are stored in `/buildroot/legal-info` directory.
