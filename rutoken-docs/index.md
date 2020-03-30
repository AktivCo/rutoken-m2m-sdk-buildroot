# Рутокен M2M SDK

Рутокен M2M SDK -- набор программного и аппаратного обеспечения, предназначенного для демонстрации и оценки возможностей продуктов из линейки [Рутокен M2M](https://www.rutoken.ru/products/all/rutoken-m2m/).

## Содержание

* [Демонстрационный комплект Рутокен M2M SDK](#%D0%B4%D0%B5%D0%BC%D0%BE%D0%BD%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B9-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BB%D0%B5%D0%BA%D1%82-%D1%80%D1%83%D1%82%D0%BE%D0%BA%D0%B5%D0%BD-m2m-sdk)
* [ОС с функциональностью Рутокен M2M](#%D0%BE%D1%81-%D1%81-%D1%84%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D1%8C%D1%8E-%D1%80%D1%83%D1%82%D0%BE%D0%BA%D0%B5%D0%BD-m2m-sdk)
    * [Учетные записи пользователей](#%D1%83%D1%87%D0%B5%D1%82%D0%BD%D1%8B%D0%B5-%D0%B7%D0%B0%D0%BF%D0%B8%D1%81%D0%B8-%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D0%B5%D0%B9)
* [Программное обеспечение](#%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%BD%D0%BE%D0%B5-%D0%BE%D0%B1%D0%B5%D1%81%D0%BF%D0%B5%D1%87%D0%B5%D0%BD%D0%B8%D0%B5)
* [Типичные сценарии использования](#%D1%82%D0%B8%D0%BF%D0%B8%D1%87%D0%BD%D1%8B%D0%B5-%D1%81%D1%86%D0%B5%D0%BD%D0%B0%D1%80%D0%B8%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)

## Демонстрационный комплект Рутокен M2M SDK

Демонстрационный комплект Рутокен M2M SDK представляет собой плату расширения **Рутокен 4990**, совместимую с ПК Raspberry Pi 2 или 3. Операционная система, собранная из исходников данного проекта, устанавливается на Raspberry Pi и позволяет взаимодействовать со смарт-картами Рутокен, размещенными на плате Рутокен 4990.

Для работы требуется:
* Raspberry Pi 2 или 3;
* USB-клавиатура;
* монитор c подключением по HDMI-кабелю;
* 2 кабеля USB A male/MicroUSB male: для питания Raspberry Pi; для подключения Рутокен 2010, размещенного на плате, к Raspberry Pi;
* SD-карта с записанным на нее образом ОС с функциональностью Рутокен M2M.

## ОС с функциональностью Рутокен M2M SDK

ОС с функциональностью Рутокен M2M является результатом сборки исходного кода данного проекта. Это ОС Linux с версией ядра 4.14. В ОС предустановлен набор программного обеспечения, предназначенного для работы со смарт-картами.

### Учетные записи пользователей:

* **demo:demo**
* **root:root**

Рекомендуется использовать учетную запись со стандартным набором привилегий **demo**.

## Программное обеспечение

В ОС установлено системное ПО, обеспечивающее работу со смарт-картами:
* Пакет [PCSClite](https://pcsclite.apdu.fr/) в составе библиотеки libpcsclite.so с интерфейсом PC/SC и демона [pcscd](https://linux.die.net/man/8/pcscd); в состав пакета входит ПО [PCSC-spy](https://ludovicrousseau.blogspot.com/2011/11/pcsc-api-spy-third-try.html), позволяющее логировать обращения к PC/SC-интерфейсу.
* [CCID драйвер](https://ccid.apdu.fr/) -- для обеспечения взаимодействия с CCID-совместимыми смарт-картами;
* [rtuart драйвер](https://github.com/AktivCo/rtuart) -- для обеспечения взаимодействия с Рутокен 4010 по последовательному интерфейсу.

Программные пакеты для работы со смарт-картами включают в себя:
* [pcsc-tools](http://ludovic.rousseau.free.fr/softwares/pcsc-tools/). Утилита **pcsc_scan** позволяет перечислять подключенные смарт-карты и получать о них базовую информацию.
* [OpenSC](https://github.com/OpenSC/OpenSC). Набор утилит [OpenSC tools](http://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html) позволяет взаимодействовать со смарт-картами через интерфейсы PC/SC, PKCS#11, управлять созданной на смарт-карте структурой PKCS#15. Среди утилит стоит отметить:
    * [**opensc-tool**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#opensc-tool): реализует базовые возможности по взаимодействию со смарт-картами, в том числе отправку APDU;
    * [**opensc-explorer**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#opensc-explorer): позволяет просматривать файловую систему смарт-карты/
    * [**pkcs11-tool**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs11-tool): позволяет выполнять различные задачи с использованием PKCS#11-интерфейса. Для Рутокен **pkcs11-tool** может использоваться с библиотекой rtPKCS11ECP (установлена в ОС по пути `/usr/lib/librtpkcs11ecp.so`) или opensc-pkcs11.
    * [**pkcs15-tool**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs15-tool): позволяет взаимодействовать с созданными на смарт-карте PKCS#15-контейнерами. Подробнее об использовании утилит OpenSC, работающих по стандарту PKCS#15 с Рутокен [тут](https://github.com/OpenSC/OpenSC/wiki/Aktiv-Co.-Rutoken-ECP).

Библиотеки Рутокен, обеспечивающие взаимодействие со смарт-картами Рутокен через различные интерфейсы:
* [**rtPKCS11ECP**](https://dev.rutoken.ru/pages/viewpage.action?pageId=3178509) -- реализует интерфейс RSALabs PKCS#11. Расположена по пути `/usr/lib/librtpkcs11ecp.so`.
* **rtengine** -- вспомогательная библиотека, позволяющая взаимодействовать со смарт-картами Рутокен через [OpenSSL API](https://www.openssl.org/docs/manmaster/man3/). Расположена по пути `/usr/lib/librtengine.so`.

Для управления размещенными на Рутокен 4990 смарт-картами и облегчения выполнения некоторых задач в ОС установлены вспомогательные утилиты из пакета [**rutoken-m2m-sdk-utils**](https://github.com/AktivCo/rutoken-m2m-sdk-utils/):
* Утилита **rt-control** позволяет подключать/отключать отдельные устройства, запускать/останавливать/перезапускать pcscd, включать/выключать логирование pcscd и драйверов смарт-карт, получать информацию о текущем состоянии устройств. Подробное описание интерфейса доступно по [ссылке](https://github.com/AktivCo/rutoken-m2m-sdk-utils/#rt-control).
* Утилита **rt-run-sample** позволяет запускать приложения, использующие интерфейс PC/SC, с включенным логированием PCSC-Spy и на определенной смарт-карте. Подробное описание интерфейса доступно по [ссылке](https://github.com/AktivCo/rutoken-m2m-sdk-utils/#rt-run-sample).
* Утилита [**rt-uart-test**](https://github.com/AktivCo/rutoken-m2m-sdk-utils/#rt-uart-test) позволяет запустить тест низкоуровневого протокола взаимодействия со смарт-картой Рутокен 4010 по последовательному интерфейсу.

В домашнюю директорию пользователя установлены примеры из состава [Rutoken SDK](https://www.rutoken.ru/developers/sdk/), позволяющие обращаться к смарт-картам через интерфейсы PKCS#11 (примеры по пути `~/sdk/pkcs11/`), OpenSSL API (примеры по пути `~/sdk/rtengine/`). По пути `~/sdk/openssl/` размещена утилита [openssl](https://www.openssl.org/docs/manmaster/man1/openssl.html), которая при использовании файла конфигурации `~/sdk/openssl/openssl.cnf` также может выполнять криптографические задачи с использованием подключенных смарт-карт.

## Типичные сценарии использования

При входе в учетную запись пользователя отображается экран приветствия, содержащий краткую информацию о возможностях использования демонстрационного комплекта и управления им.

### Утилита rt-control

#### rt-control: управление подключением устройств

* Просмотреть, какие устройства сейчас подключены:

```
rt-control -i
```

<details>
<summary>Пример</summary>

```
$ rt-control -i

Devices physical state information■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 Rutoken 2010      SoC      (usb)       connected       to RPi2 ■
 Rutoken 4010      SOM      (uart)      connected       to RPi2 ■
 Rutoken 2151/2100 MicroSIM (sc)        not connected   to RPi2 ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

PCSCD■■■■■■■■■
 running     ■
■■■■■■■■■■■■■■

Devices availiability information■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 Rutoken 2010      SoC      (usb)   is  available      over PC/SC driver ■
 Rutoken 4010      SOM      (uart)  is  available      over PC/SC driver ■
 Rutoken 2151/2100 MicroSIM (sc)    is  not available  over PC/SC driver ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

Logging information■■■■■■■■■■■■■
 PCSCD   logging     disabled  ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 CCID    logging     disabled  ■
         log level   0         ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 RTUART  logging     disabled  ■
         log level   0         ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
```

</details>

* Включить только Рутокен 2010:

```
sudo rt-control -s 2010
```

* Включить только Рутокен 4010:

```
sudo rt-control -s 4010
```

* Включить Рутокен 2010 и Рутокен 4010:

```
sudo rt-control -s 2010 4010
```

#### rt-control: управление логированием

Есть возможность включить логирование pcscd и драйверов ccid и rtuart (опционально, но с включенным логированием pcscd). Лог пишется в syslog, на файловую систему он отображается в файл `/var/log/messages`; для просмотра можно использовать:

```
tail -n 20 /var/log/messages
```

* Включить логирование pcscd (опция -- строчная `L`) и установить уровни логирования драйверов ccid и rtuart в значение по умолчанию (3):

```
sudo rt-control -l
```

* Включить логирование pcscd, установить уровень логирования ccid в 7 -- логируются вызовы интерфейса, нет периодических сообщений; rtuart -- в 3:

```
sudo rt-control -l -c 7
```

* Включить логирование pcscd, установить уровень логирования rtuart в 7 -- логируются вызовы интерфейса, нет периодических сообщений; ccid -- в 3:

```
sudo rt-control -l -u 7
```

* Выключить логирование:

```
sudo rt-control -d
```

#### rt-control: Запуск, остановка, перезапуск pcscd:

```
sudo rt-control -p start
sudo rt-control -p stop
sudo rt-control -p restart
```

### Стандартные и opensource утилиты

#### Просмотреть подключенные устройства:
* `lsusb` - просмотреть подключенные usb устройства
* `pcsc_scan` - просмотреть, какие устройства доступны через PC/SC
* `opensc-tool -l` - просмотреть, какие устройства доступны через PC/SC

#### Отправка APDU-команд

* `opensc-tool -r 0 -s 80400000` -- подключиться к первому считывателю и отправить команду `80400000`

* Отправка серии команд

```
opensc-explorer -r 0
OpenSC [3F00]> apdu 00 20 00 02 08 31 32 33 34 35 36 37 
```

<details>
<summary>Подробнее -- логин, еще логин, сброс прав, логин</summary>

```
opensc-explorer -r 0
OpenSC [3F00]> apdu 00 20 00 02 08 31 32 33 34 35 36 37 38
Sending: 00 20 00 02 08 31 32 33 34 35 36 37 38
Received (SW1=0x90, SW2=0x00)
Success!
OpenSC [3F00]> apdu 00 20 00 02 08 31 32 33 34 35 36 37 38
Sending: 00 20 00 02 08 31 32 33 34 35 36 37 38
Received (SW1=0x6F, SW2=0x86)
Failure: Card command failed
OpenSC [3F00]> apdu 80 40 00 00
Sending: 80 40 00 00
Received (SW1=0x90, SW2=0x00)
Success!
OpenSC [3F00]> apdu 00 20 00 02 08 31 32 33 34 35 36 37 38
Sending: 00 20 00 02 08 31 32 33 34 35 36 37 38
Received (SW1=0x90, SW2=0x00)
Success!
```
</details>

#### Интерфейс pkcs#11 -- pkcs11-tool

Должна использоваться библиотека `/usr/lib/librtpkcs11ecp.so`

* Просмотр токенов: 

```
pkcs11-tool --module /usr/lib/librtpkcs11ecp.so -L
```

* Просмотр объектов на токене в нулевом слоте: 

```
pkcs11-tool --module /usr/lib/librtpkcs11ecp.so --slot 0 -l -p 12345678 -O
```

### Запуск примеров Рутокен SDK

Примеры Рутокен SDK размещены по пути `~/sdk/pkcs11`, `~/sdk/rtengine`, `~/sdk/openssl`.

Примеры pkcs#11 и rtengine рассчитаны на подключение одного токена, поэтому перед запуском стоит сделать `sudo rt-control -s 2010` или `sudo rt-control -s 4010`. Альтернативный вариант -- запуск через утилиту `rt-run-sample`, например, такая команда запустит пример на Рутокен 4010:

```
sudo rt-run-sample -d 4010 -p sdk/pkcs11/CreateRSA
```

### Демонстрация низкоуровневого протокола обмена данными по UART

В лог попадают данные пакетов Transport API. Запуск с помощью утилиты:

```
sudo rt-uart-test -f
```
