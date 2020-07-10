[English/Английский](README_EN.rutoken.md)

# [Описание Рутокен M2M SDK](rutoken-docs/index.md) 

# Buildroot для Рутокен M2M SDK 

Этот проект предназначен для создания образа операционной системы Linux, использующегося в [Рутокен M2M SDK](https://www.rutoken.ru/products/all/rutoken-m2m/). Этот проект является ответвлением проекта [Buildroot](https://buildroot.org/).

Аппаратная платформа Рутокен M2M SDK представляет из себя демонстрационную плату Рутокен 4990, устанавливаемую на одноплатные ПК Raspberry Pi версии 2 или 3. На демонстрационной плате размещены смарт-карты Рутокен 2010, Рутокен 4010 и считыватель смарт-карт в формате микро-SIM.

Образ операционной системы Linux для Raspberry Pi, созданный при помощи этого проекта, служит программной платформой Рутокен M2M SDK.

Программные пакеты, установленные в ОС, предоставляют возможность использования смарт-карт через различные программные интерфейсы. Среди них широко известные программные пакеты с открытым исходным кодом [pcsclite](https://pcsclite.apdu.fr/), [OpenSC](https://github.com/OpenSC/OpenSC), [CCID](https://ccid.apdu.fr/). Взаимодействие с Рутокен 4010 по последовательному интерфейсу обеспечивается посредством драйвера [rtuart](https://github.com/AktivCo/rtuart). Взаимодействие со смарт-картами, подключенными в считыватель смарт-карт, осуществляется посредством драйвера [rtuartscreader](https://github.com/AktivCo/rtuartscreader). Для обзора возможностей использования смарт-карт в образ ОС добавлены примеры из [Рутокен SDK](https://www.rutoken.ru/developers/sdk/), которые осуществляют взаимодействие со смарт-картами на демонстрационной плате через различные программные интерфейсы:
* [RSALabs PKCS#11](https://dev.rutoken.ru/display/PUB/PKCS%2311) -- с использованием проприетарной библиотеки [rtPKCS11ECP](https://www.rutoken.ru/support/download/pkcs/), 
* [OpenSSL API](https://www.openssl.org/docs/manmaster/man3/) -- с использованием проприетарного [engine](https://github.com/openssl/openssl/blob/OpenSSL_1_1_1e/README.ENGINE) -- rtengine,
* [PC/SC](https://pcsclite.apdu.fr/api/group__API.html).

## Как собрать образ ОС

#### Общие принципы

Типичная последовательность команд для сборки проекта Buildroot:

```
make <target_defconfig>
make
```

Для Рутокен M2M SDK определены следующие конфигурации платформы:
* `rutoken_m2m_rpi2_defconfig` для Raspberry Pi 2;
* `rutoken_m2m_rpi3_defconfig` для Raspberry Pi 3.

#### Готовый пример сборки

Для сборки образа ОС с функциональностью Рутокен M2M SDK для Raspberry Pi 3, можно воспользоваться следующими командами:

```
make rutoken_m2m_rpi3_defconfig
make
```

Образ sd-карты с ОС расположен по пути `output/images/sdcard.img`.

#### Запись образа на sd-карту

Для записи образа на карту можно воспользоваться приложением [balenaEtcher](https://www.balena.io/etcher/) или воспользоваться инструкциями на [raspberripy.org](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) для соответствующей платформы: [Linux](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md), [Mac OS X](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md), [Windows](https://www.raspberrypi.org/documentation/installation/installing-images/windows.md).

Ниже приведена русскоязычная инструкция по записи образа на sd-карту в ОС Linux.

1. Подключите SD-карту к компьютеру.
2. Определите имя устройства, соответствующего SD-карте. Для этого выполните вызов `lsblk -p` до и после подключения карты. Появившаяся после подключения SD-карты запись с типом "disk" соответствует подключенной SD-карте; имя устройства указано в первой колонке вывода команды (например, `sdb`). Путь до файла устройства, соответствующего SD-карте -- `/dev/sdb`.
3. В случае, если подключенная карта была автоматически подмонтирована, отмонтируйте ее разделы (например, `umount /dev/sdb1`).
4. Выполните запись образа на карту при помощи утилиты `dd`:

```
sudo dd if=sdcard.img of=/dev/sdb bs=1M oflag=dsync
```

В вызов команды можно добавить параметр `status=progress`, чтобы отслеживать прогресс выполнения команды.

5. Если после записи данных на карту разделы автоматически примонтировались, отмонтируйте их:

```
umount /dev/sdb1
umount /dev/sdb2
```

#### Сборка дистрибутива для распространения

Большинство программных пакетов в сборке дистрибутива с функциональностью Рутокен M2M SDK имеют открытый исходный код и, согласно лицензиям, требуют распространения исходного кода вместе с бинарными файлами. Во исполнение данных требований мы переносим содержимое директории `${BASE_DIR}/legal-info` (BASE_DIR -- это выходная директория) в директорию `/usr/share/legal-info` дистрибутива. Таким образом, последовательность команд сборки дистрибутива для распространения следующая:

```
make rutoken_m2m_rpi3_defconfig
make legal-info # Buildroot создает и заполняет директорию output/legal-info
make
```

## Больше информации

Более подробную информацию о Buildroot можно найти в [Руководстве пользователя Buildroot](https://buildroot.org/downloads/manual/manual.html).

Дополнительная информация о Рутокен M2M SDK доступна в [документации](rutoken-docs/index.md) проекта.

## Лицензия

Проект является производным от проекта Buildroot. Проект распространяется по той же самой лицензии,
что и Buildroot; условия и текст лицензии доступны в файле [COPYING](COPYING).