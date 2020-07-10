# Рутокен M2M SDK

Рутокен M2M SDK -- набор программного и аппаратного обеспечения, предназначенного для демонстрации и оценки возможностей продуктов из линейки [Рутокен M2M](https://www.rutoken.ru/products/all/rutoken-m2m/).

<!-- Use https://github.com/naokazuterada/MarkdownTOC for sublime text -->
<!-- MarkdownTOC autolink="true" bullets="*" lowercase="all" -->

* [Состав Рутокен M2M SDK](#%D1%81%D0%BE%D1%81%D1%82%D0%B0%D0%B2-%D1%80%D1%83%D1%82%D0%BE%D0%BA%D0%B5%D0%BD-m2m-sdk)
  * [Программный стек](#%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%BD%D1%8B%D0%B9-%D1%81%D1%82%D0%B5%D0%BA)
* [Использование демонстрационного комплекта Рутокен M2M SDK](#%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B4%D0%B5%D0%BC%D0%BE%D0%BD%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BB%D0%B5%D0%BA%D1%82%D0%B0-%D1%80%D1%83%D1%82%D0%BE%D0%BA%D0%B5%D0%BD-m2m-sdk)
  * [Вход в операционную систему](#%D0%B2%D1%85%D0%BE%D0%B4-%D0%B2-%D0%BE%D0%BF%D0%B5%D1%80%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%83%D1%8E-%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D1%83)
  * [Управление демонстрационными возможностями](#%D1%83%D0%BF%D1%80%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B4%D0%B5%D0%BC%D0%BE%D0%BD%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8F%D0%BC%D0%B8)
  * [Демонстрация взаимодействия со смарт-картами](#%D0%B4%D0%B5%D0%BC%D0%BE%D0%BD%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D1%8F-%D0%B2%D0%B7%D0%B0%D0%B8%D0%BC%D0%BE%D0%B4%D0%B5%D0%B9%D1%81%D1%82%D0%B2%D0%B8%D1%8F-%D1%81%D0%BE-%D1%81%D0%BC%D0%B0%D1%80%D1%82-%D0%BA%D0%B0%D1%80%D1%82%D0%B0%D0%BC%D0%B8)
    * [Просмотр подключенных устройств](#%D0%BF%D1%80%D0%BE%D1%81%D0%BC%D0%BE%D1%82%D1%80-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%BD%D1%8B%D1%85-%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2)
    * [Отправка APDU-команд](#%D0%BE%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%BA%D0%B0-apdu-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4)
    * [Использование интерфейса PKCS#11 через pkcs11-tool](#%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D1%84%D0%B5%D0%B9%D1%81%D0%B0-pkcs11-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-pkcs11-tool)
    * [Запуск примеров Рутокен SDK](#%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D0%BE%D0%B2-%D1%80%D1%83%D1%82%D0%BE%D0%BA%D0%B5%D0%BD-sdk)
    * [Демонстрация низкоуровневого протокола обмена данными по UART](#%D0%B4%D0%B5%D0%BC%D0%BE%D0%BD%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D1%8F-%D0%BD%D0%B8%D0%B7%D0%BA%D0%BE%D1%83%D1%80%D0%BE%D0%B2%D0%BD%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE-%D0%BF%D1%80%D0%BE%D1%82%D0%BE%D0%BA%D0%BE%D0%BB%D0%B0-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BF%D0%BE-uart)
  * [Модификация программного обеспечения демонстрационного комплекта](#%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F-%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BE%D0%B1%D0%B5%D1%81%D0%BF%D0%B5%D1%87%D0%B5%D0%BD%D0%B8%D1%8F-%D0%B4%D0%B5%D0%BC%D0%BE%D0%BD%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BB%D0%B5%D0%BA%D1%82%D0%B0)
    * [Пример последовательности действий по модификации пакета](#%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%80-%D0%BF%D0%BE%D1%81%D0%BB%D0%B5%D0%B4%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D0%B8-%D0%B4%D0%B5%D0%B9%D1%81%D1%82%D0%B2%D0%B8%D0%B9-%D0%BF%D0%BE-%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BF%D0%B0%D0%BA%D0%B5%D1%82%D0%B0)
    * [Изменение конфигурации для сборки пакета из локальной директории](#%D0%B8%D0%B7%D0%BC%D0%B5%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D0%B8-%D0%B4%D0%BB%D1%8F-%D1%81%D0%B1%D0%BE%D1%80%D0%BA%D0%B8-%D0%BF%D0%B0%D0%BA%D0%B5%D1%82%D0%B0-%D0%B8%D0%B7-%D0%BB%D0%BE%D0%BA%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B9-%D0%B4%D0%B8%D1%80%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D0%B8%D0%B8)
    * [Модификация примеров Рутокен SDK](#%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D0%BE%D0%B2-%D1%80%D1%83%D1%82%D0%BE%D0%BA%D0%B5%D0%BD-sdk)

<!-- /MarkdownTOC -->

## Состав Рутокен M2M SDK

Демонстрационный комплект Рутокен M2M SDK представляет собой плату расширения [**Рутокен 4990**](https://www.rutoken.ru/products/all/rutoken-m2m/#models), подключаемую к ПК Raspberry Pi 2 или Raspberry Pi 3.

На демонстрационной плате Рутокен 4990 размещены смарт-карты Рутокен 2010, Рутокен 4010 и считыватель смарт-карт в формате микро-SIM. Принципиальная электрическая схема демонстрационной платы Рутокен 4990 по [ссылке](assets/Rutoken4990scheme.pdf)

Программное обеспечение, позволяющее взаимодействовать со смарт-картами линейки Рутокен M2M, размещенными на плате расширения **Рутокен 4990**, предустановлено в операционную систему, собранную из исходников проекта [Rutoken M2M SDK Buildroot](https://github.com/AktivCo/rutoken-m2m-sdk-buildroot) и запускаемую на Raspberry Pi.

Операционная система Рутокен M2M SDK основана на ядре Linux 4.14.

В ОС установлено системное ПО, обеспечивающее работу со смарт-картами:
* Пакет [PCSClite](https://pcsclite.apdu.fr/) в составе библиотеки libpcsclite.so с интерфейсом PC/SC и демона [pcscd](https://linux.die.net/man/8/pcscd); в состав пакета входит ПО [PCSC-spy](https://ludovicrousseau.blogspot.com/2011/11/pcsc-api-spy-third-try.html), позволяющее логировать обращения к PC/SC-интерфейсу.
* [CCID драйвер](https://ccid.apdu.fr/) -- для обеспечения взаимодействия с CCID-совместимыми смарт-картами;
* [rtuart драйвер](https://github.com/AktivCo/rtuart) -- для обеспечения взаимодействия с Рутокен 4010 по последовательному интерфейсу;
* [rtuartscreader драйвер](https://github.com/AktivCo/rtuartscreader) -- для обеспечения взаимодействия со смарт-картами Рутокен 2151 и Рутокен 2100, подключенными в колодку считывателя смарт-карт в формате микро-SIM, с использованием последовательного интерфейса и GPIO-контактов Raspberry Pi.

Программные пакеты для работы со смарт-картами включают в себя:
* [pcsc-tools](http://ludovic.rousseau.free.fr/softwares/pcsc-tools/). Утилита **pcsc_scan** позволяет перечислять подключенные смарт-карты и получать о них базовую информацию.
* [OpenSC](https://github.com/OpenSC/OpenSC). Набор утилит [OpenSC tools](http://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html) позволяет взаимодействовать со смарт-картами через интерфейсы PC/SC, PKCS#11, управлять созданной на смарт-карте структурой PKCS#15. Среди утилит стоит отметить:
    * [**opensc-tool**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#opensc-tool): реализует базовые возможности по взаимодействию со смарт-картами, в том числе отправку APDU;
    * [**opensc-explorer**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#opensc-explorer): позволяет просматривать файловую систему смарт-карты/
    * [**pkcs11-tool**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs11-tool): позволяет выполнять различные задачи с использованием PKCS#11-интерфейса. Для Рутокен **pkcs11-tool** может использоваться с библиотекой rtPKCS11ECP (установлена в ОС по пути `/usr/lib/librtpkcs11ecp.so`) или opensc-pkcs11.
    * [**pkcs15-tool**](https://htmlpreview.github.io/?https://github.com/OpenSC/OpenSC/blob/master/doc/tools/tools.html#pkcs15-tool): позволяет взаимодействовать с созданными на смарт-карте PKCS#15-контейнерами. Подробнее об использовании утилит OpenSC, работающих по стандарту PKCS#15 с Рутокен [тут](https://github.com/OpenSC/OpenSC/wiki/Aktiv-Co.-Rutoken-ECP).

Библиотеки Рутокен, обеспечивающие взаимодействие со смарт-картами Рутокен через различные интерфейсы:
* [**rtPKCS11ECP**](https://dev.rutoken.ru/pages/viewpage.action?pageId=3178509) -- реализует интерфейс RSALabs PKCS#11. Расположена по пути `/usr/lib/librtpkcs11ecp.so`.
* [**rtengine**](https://dev.rutoken.ru/display/PUB/OpenSSL+API) -- вспомогательная библиотека, позволяющая взаимодействовать со смарт-картами Рутокен через [OpenSSL API](https://www.openssl.org/docs/manmaster/man3/). Расположена по пути `/usr/lib/librtengine.so`.

Для управления размещенными на Рутокен 4990 смарт-картами и облегчения выполнения некоторых задач в ОС установлены вспомогательные утилиты из пакета [**rutoken-m2m-sdk-utils**](https://github.com/AktivCo/rutoken-m2m-sdk-utils/):
* Утилита [**rt-control**](https://github.com/AktivCo/rutoken-m2m-sdk-utils/blob/master/README_RUS.md#rt-control) позволяет подключать/отключать отдельные устройства, запускать/останавливать/перезапускать pcscd, включать/выключать логирование pcscd и драйверов смарт-карт, получать информацию о текущем состоянии устройств.
* Утилита [**rt-run-sample**](https://github.com/AktivCo/rutoken-m2m-sdk-utils/blob/master/README_RUS.md#rt-run-sample) позволяет запускать приложения, использующие интерфейс PC/SC, с включенным логированием PCSC-Spy и на определенной смарт-карте.
* Утилита [**rt-uart-test**](https://github.com/AktivCo/rutoken-m2m-sdk-utils/blob/master/README_RUS.md#rt-uart-test) позволяет запустить тест низкоуровневого протокола взаимодействия со смарт-картой Рутокен 4010 по последовательному интерфейсу.

В домашнюю директорию пользователя установлены примеры из состава [Rutoken SDK](https://www.rutoken.ru/developers/sdk/), позволяющие обращаться к смарт-картам через интерфейсы PKCS#11 (примеры по пути `~/sdk/pkcs11/`), OpenSSL API (примеры по пути `~/sdk/rtengine/`). По пути `~/sdk/openssl/` размещена утилита [openssl](https://www.openssl.org/docs/manmaster/man1/openssl.html), которая при использовании файла конфигурации `~/sdk/openssl/openssl.cnf` также может выполнять криптографические задачи с использованием подключенных смарт-карт.

### Программный стек

Стек программного обеспечения, осуществляющего взаимодействия со смарт-картами, устроен следующим образом:

<table>
  <tr>
    <td>Тип</td>
    <td>Рутокен 2010</td>
    <td>Рутокен 4010</td>
    <td>Рутокен 2100/2151</td>
  </tr>
  <tr>
    <td>Системный транспорт низкоуровневого интерфейса</td>
    <td>USB</td>
    <td>UART</td>
    <td>UART + GPIO</td>
  </tr>
  <tr>
    <td>Драйвер считывателя/IFDHandler</td>
    <td>libccid</td>
    <td>librtuart</td>
    <td>librtuartscreader</td>
  </tr>
  <tr>
    <td>PC/SC</td>
    <td colspan="3">pcscd + libpcsclite</td>
  </tr>
  <tr>
    <td>PKCS#11</td>
    <td colspan="3">librtpkcs11ecp</td>
  </tr>
</table>

Пользовательское программное обеспечение, как правило, использует для взаимодействия со смарт-картами интерфейс PC/SC или PKCS#11.

## Использование демонстрационного комплекта Рутокен M2M SDK

Для работы требуется:
* Raspberry Pi 2 или 3;
* плата расширения Рутокен 4990;
* 2 кабеля USB A male/MicroUSB male: для питания Raspberry Pi; для подключения Рутокен 2010, размещенного на плате, к Raspberry Pi;
* SD-карта с записанным на нее образом ОС с функциональностью Рутокен M2M SDK; для установки образа на карту можно воспользоваться [инструкцией](install-image.md);
* патч-корд с коннекторами RJ-45 на концах (если планируется осуществлять доступ к устройству по сети);
* USB-клавиатура;
* монитор c подключением по HDMI.

Взаимодействие с Raspberry Pi может осуществляться непосредственно с помощью монитора и клавиатуры или по сети по протоколу ssh. В настоящей версии предусмотрено только проводное подключение Raspberry Pi к сети.

Для настройки взаимодействия по ssh воспользуйтесь рекомендациями по [ссылке](ssh.md).

### Вход в операционную систему

Вход в систему возможен при использовании следующих учетные данных пользователей:
* **demo:demo** -- непривилегированный пользователь;
* **root:root** -- привилегированный пользователь.

Рекомендуется использовать учетную запись со стандартным набором привилегий **demo**.

При входе в учетную запись пользователя отображается экран приветствия, содержащий краткую информацию о возможностях использования демонстрационного комплекта и управления им.

### Управление демонстрационными возможностями

Для управления демонстрационными возможностями комплекта Рутокен M2M SDK в состав ОС включена утилита **rt-control**, позволяющая:
* выполнять аппаратное или программное отключение смарт-карты. В соответствии с принципиальной схемой платы Рутокен 4990 смарт-карта Рутокен 4010 и считыватель смарт-карт в формате micro-SIM не могут быть одновременно подключены к Raspberry Pi, так как оба устройства взаимодействуют с ПК через UART. Некоторое программное обеспечение (например, примеры работы через PKCS#11 из Rutoken SDK) рассчитано на наличие только одной подключенной смарт-карты. Утилита **rt-control** выполняет отключение карт таким образом, что они перестают быть доступны через интерфейс PC/SC (это не обязательно физическое отключение устройства или отключение низкоуровневого интерфейса).
* включать и выключать логирование pcscd и драйверов считывателей. Логи pcscd включают в себя информацию об отправляемых на смарт-карту APDU. Лог драйвера считывателя позволяет получить практическое представление о низкоуровневых протоколах взаимодействия со смарт-картой. Лог пишется в syslog, на файловую систему он отображается в файл `/var/log/messages`; для просмотра можно использовать:

```
tail -n 20 /var/log/messages # Просмотреть последние 20 строк
tail -f /var/log/messages # Отслеживать появление новых записей
```

* получать информацию о текущем состоянии настроек демонстрационных возможностей.
* управлять запуском и остановкой pcscd. Некоторые примеры в составе Rutoken M2M SDK работают напрямую с устройством без использования интерфейса PC/SC. Для их корректной работы pcscd должен быть остановлен.

Полное описание утилиты **rt-control** доступно по [ссылке](https://github.com/AktivCo/rutoken-m2m-sdk-utils/blob/master/README_RUS.md).

Ниже представлены примеры использования утилиты.

* Просмотреть, какие устройства сейчас подключены:

```
rt-control -i
```

<details>
<summary>Вывод команды</summary>

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

Logging information■■■■■■■■■■■■■■■■■■■■
 PCSCD          logging     disabled  ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 CCID           logging     disabled  ■
                log level   0         ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 RTUART         logging     disabled  ■
                log level   0         ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
 RTUARTSCREADER logging     disabled  ■
                log level   0         ■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
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

* Включить только считыватель смарт-карт:

```
sudo rt-control -s 21xx
```

* Включить Рутокен 2010 и Рутокен 4010:

```
sudo rt-control -s 2010 4010
```

* Включить логирование pcscd (опция -- строчная `L`) и установить уровни логирования драйверов ccid, rtuart, rtuartscreader в значение по умолчанию (3):

```
sudo rt-control -l
```

* Включить логирование pcscd, установить уровень логирования ccid в 7 -- логируются вызовы интерфейса, нет периодических сообщений; rtuart и rtuartscreader -- в 3:

```
sudo rt-control -l -c 7
```

* Включить логирование pcscd, установить уровень логирования rtuart в 7 -- логируются вызовы интерфейса, нет периодических сообщений; ccid и rtuartscreader -- в 3:

```
sudo rt-control -l -u 7
```

* Включить логирование pcscd, установить уровень логирования rtuartscreader в 7 -- логируются вызовы интерфейса, нет периодических сообщений; ccid и rtuart -- в 3:

```
sudo rt-control -l -s 7
```

* Выключить логирование:

```
sudo rt-control -d
```

* Запускать, останавливать, перезапускать pcscd:

```
sudo rt-control -p start
sudo rt-control -p stop
sudo rt-control -p restart
```

### Демонстрация взаимодействия со смарт-картами

Для взаимодействия используются стандартные opensource утилиты и специально разработанные примеры.

#### Просмотр подключенных устройств
* `lsusb` - просмотреть подключенные USB-устройства
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

#### Использование интерфейса PKCS#11 через pkcs11-tool

Должна использоваться библиотека `/usr/lib/librtpkcs11ecp.so`

* Просмотр подключенных токенов: 

```
pkcs11-tool --module /usr/lib/librtpkcs11ecp.so -L
```

* Просмотр объектов на токене в нулевом слоте:

```
pkcs11-tool --module /usr/lib/librtpkcs11ecp.so --slot 0 -l -p 12345678 -O
```

#### Запуск примеров Рутокен SDK

Примеры Рутокен SDK размещены по пути `~/sdk/pkcs11`, `~/sdk/rtengine`, `~/sdk/openssl`.

Примеры PKCS#11 и rtengine рассчитаны на подключение одного токена, поэтому перед запуском стоит сделать `sudo rt-control -s 2010`, или `sudo rt-control -s 4010`, или `sudo rt-control -s 21xx`. Альтернативный вариант -- запуск через утилиту `rt-run-sample`, например, такая команда запустит пример на Рутокен 4010:

```
sudo rt-run-sample -d 4010 -p sdk/pkcs11/CreateRSA
```

#### Демонстрация низкоуровневого протокола обмена данными по UART

В лог попадают данные пакетов Transport API. Запуск с помощью утилиты:

```
sudo rt-uart-test -f
```

### Модификация программного обеспечения демонстрационного комплекта

Поскольку программное обеспечение демонстрационного комплекта собирается при помощи Buildroot, сборку модифицированных версий также рекомендуется выполнять при помощи Buildroot. Следует заметить, что для изменения какого-либо одного пакета не требуется пересборка всего образа ОС. После однократной полной сборки образа отдельные пакеты могут быть пересобраны независимо в соответствии с рекомендациями [инструкции к Buildroot](https://buildroot.org/downloads/manual/manual.html#rebuild-pkg). К сожалению, в случае сборки многомодульных пакетов самым простым способом доставки измененного ПО на Raspberry Pi будет упаковка и запись нового образа на SD-карту.

#### Пример последовательности действий по модификации пакета

Изначально образ SD-карты был собран следующими командами:

```
make rutoken_m2m_rpi3_defconfig
make
```

В директории `output/build/` находятся разархивированные версии пакетов, используемые для сборки образа.

Производится модификация исходного кода модуля rtuart версии v1.0.0:
```
sed 's/Rutoken ECP B/Rutoken ECP B 00/' output/build/rtuart-v1.0.0/rtuart/librtuart.in
```

Производится пересборка пакета:
```
make rtuart-rebuild
```

На этом этапе модифицированная версия пакета была установлена в директорию `output/target/`, являющуюся rootfs собираемого образа ОС.

Производится сборка образа SD-карты:
```
make
```

Новый образ записывается на SD-карту:
```
sudo dd if=output/images/sdcard.img of=/dev/sdb bs=1M oflag=dsync status=progress
```

#### Изменение конфигурации для сборки пакета из локальной директории

В случае, если требуется работать с исходным кодом пакета вне директории `output/build`, требуется модифицировать файл конфигурации пакета, находящегося внутри соответствующей пакету поддиректории внутри директории `package/`. Файл конфигурации пакета имеет имя `<your packet name>.mk`.

Пример модифицированного файла конфигурации для модуля rtuartscreader:
```
RTUARTSCREADER_VERSION = buildroot-master
RTUARTSCREADER_SITE_METHOD = local
RTUARTSCREADER_SITE = /path/to/your/rtuartscreader
RTUARTSCREADER_INSTALL_TARGET = YES
RTUARTSCREADER_LICENSE = BSD-2-Clause, BSD-3-Clause (PCSC headers, googletest), BSL-1.0 (boost-preprocessor), Unlicense (pigpio)
RTUARTSCREADER_LICENSE_FILES = LICENSE

RTUARTSCREADER_CONF_OPTS = -DRTUARTSCREADER_SERIAL_PORT="/dev/ttyAMA0" -DRTUARTSCREADER_BUILD_UNITTESTS=OFF

$(eval $(cmake-package))

```

Установка переменной `RTUARTSCREADER_SITE_METHOD` в значение `local` указывает системе сборки Buildroot получать файлы для сборки модуля из локальной директории, указанной в качестве значения переменной `RTUARTSCREADER_SITE`.

При сборке с указанием источника `local` значение переменной `RTUARTSCREADER_SOURCE` не учитывается, используются файлы модуля, найденные по пути, указанному в переменной `RTUARTSCREADER_SITE`.

#### Модификация примеров Рутокен SDK

В случае, когда известны пути установки пакета, можно обойтись без пересборки и обновления образа SD-карты. Вместо этого результаты сборки пакета можно переместить в файловую систему Raspberry Pi вручную (например, по ssh). Файловая система, повторяющая ту, что попадает в образ SD-карты, находится по пути `output/target/`. предложенным способом образом может производиться модификация примеров Рутокен SDK. Пример последовательности команд для выполнения задачи приведен ниже.

* Производится модификация исходного кода модуля rutoken-sdk-pkcs11-samples версии 180919-80c054:
```
sed 's/CK_ULONG rsaModulusBits = 512;/CK_ULONG rsaModulusBits = 1024;/' -i \
output/build/rutoken-sdk-pkcs11-samples-180919-80c054/sdk/pkcs11/samples/include/Common.h
```

* Производится пересборка пакета:
```
make rutoken-sdk-pkcs11-samples-rebuild
```

* Известно, что исполняемые модули пакета устанавливаются в rootfs по пути `/opt/Rutoken/workspace/sdk/pkcs11/`. Если Raspberry Pi доступна по адресу `192.168.0.17`, то модифицированные исполняемые модули можно скопировать туда по ssh:

```
scp -r output/target/opt/Rutoken/workspace/pkcs11 demo@192.168.0.17:~/modified-pkcs11-samples
```
