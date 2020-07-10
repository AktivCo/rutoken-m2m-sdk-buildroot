# Запись образа на sd-карту

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