[Русский/Russian](README_RUS.rutoken.md)

# Rutoken M2M SDK Buildroot

This project is used to generate an embedded Linux system constituting the software part [Rutoken M2M SDK](https://www.rutoken.ru/products/all/rutoken-m2m/). The project is a fork of [Buildroot](https://buildroot.org/) project.

Rutoken M2M SDK hardware is Rutoken 4990 demonstration board compatible with Raspberry Pi 2 or 3 PCs. It hosts Rutoken 2010 and Rutoken 4010 smartcards and a microSIM reader.

The Linux system for Raspberry Pi generated with the use of this project constitutes the software part of Rutoken M2M SDK.

The software packages installed on the Linux system facilitate the use of smartcards. Among them there are widely-known opensource packages [pcsclite](https://pcsclite.apdu.fr/), [OpenSC](https://github.com/OpenSC/OpenSC), [CCID](https://ccid.apdu.fr/). The communication with Rutoken 4010 connected over a serial interface is provided with [rtuart](https://github.com/AktivCo/rtuart) driver. The user can assess the usage of the Rutoken smartcards by running samples from [Rutoken SDK](https://www.rutoken.ru/developers/sdk/), that communicate with the smartcards over various APIs:
* [RSALabs PKCS#11](https://www.cryptsoft.com/pkcs11doc/) -- provided by vendor's [rtPKCS11ECP](https://www.rutoken.ru/support/download/pkcs/) library,
* [OpenSSL API](https://www.openssl.org/docs/manmaster/man3/) (with the use of vendor's [engine](https://github.com/openssl/openssl/blob/OpenSSL_1_1_1e/README.ENGINE) -- rtengine,
* [PC/SC](https://pcsclite.apdu.fr/api/group__API.html).

## How to build

#### General principles

The typical build pipeline for Buildroot project is:

```
make <target_defconfig>
make
```

The configs for Rutoken M2M SDK are:
* `rutoken_m2m_rpi2_defconfig` for Raspberry Pi 2;
* `rutoken_m2m_rpi3_defconfig` for Raspberry Pi 3.

#### Copy&Paste example

To build the image with Rutoken M2M SDK for Raspberry Pi 3, perform the following commands from the project root directory:

```
make rutoken_m2m_rpi3_defconfig
make
```

The path to sdcard image built is `output/images/sdcard.img`.

#### Production build

Most software packages in Rutoken M2M SDK distribution are opensource and their licenses require distributing sources as well as binaries. To fulfill the requirements we transfer the contents of `${BASE_DIR}/legal-info` directory (BASE_DIR points to the output directory) into `/usr/share/legal-info` directory of the binary distribution. Thus the pipeline to build production distribution is as follows:

```
make rutoken_m2m_rpi3_defconfig
make legal-info # this creates output/legal-info directory
make
```

## More info

For more information about the Buildroot see [The Buildroot user manual](https://buildroot.org/downloads/manual/manual.html).

For more information about Rutoken M2M SDK see [project docs](rutoken-docs/index.md)

## License

The project is derived from the Buildroot. The project is distributed under the
same license as the Buildroot -- see the [COPYING](COPYING) file for the license.
