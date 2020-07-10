# Подключение к Raspberry Pi по сети

В текущей версии Rutoken M2M SDK настройки операционной системы позволяют выполнять только проводное подключение к Raspberry Pi. В ОС настроен dhcp-клиент, поэтому устройство при подключении к роутеру автоматически получает ip-адрес.

В случае, если у вас есть доступ к Raspberry Pi при помощи клавиатуры и монитора, вы можете узнать сетевой адрес компьютера, выполнив команду `ifconfig eth0`; значение сетевого адреса находится после метки `inet addr:`.

Без подключения монитора и клавиатуры к Raspberry Pi для определения ip-адреса можно воспользоваться сетевым сканером nmap.

Выполните вызов `nmap -sn <your subnetwork mask>` до и после подключения Raspberry Pi к сети. Новый адрес, появившийся в выводе команды после подключения Raspberry Pi, скорее всего, искомый.

Подключение по ssh к Raspberry Pi выполняется командой `ssh demo@<raspberry pi ip-address>`. Для копирование данных по ssh можно воспользоваться командой `scp`.

### Пример

Сканируем локальную подсеть перед подключением Raspberry Pi к сети:

```
$ nmap -sn 10.0.0.*
Starting Nmap 7.80 ( https://nmap.org ) at 2020-07-15 11:19 MSK
Nmap scan report for 10.0.0.1
Host is up (0.013s latency).
Nmap scan report for 10.0.0.13
Host is up (0.00029s latency).
Nmap scan report for 10.0.0.14
Host is up (0.0037s latency).
Nmap done: 256 IP addresses (3 hosts up) scanned in 3.13 seconds
```

Сканируем локальную подсеть после подключения Raspberry Pi к сети:

```
$ nmap -sn 10.0.0.*
Starting Nmap 7.80 ( https://nmap.org ) at 2020-07-15 11:21 MSK
Nmap scan report for 10.0.0.1
Host is up (0.013s latency).
Nmap scan report for 10.0.0.13
Host is up (0.00029s latency).
Nmap scan report for 10.0.0.14
Host is up (0.0037s latency).
Nmap scan report for 10.0.0.15
Host is up (0.073s latency).
Nmap done: 256 IP addresses (4 hosts up) scanned in 3.13 seconds
```

Появившийся хост с адресом `10.0.0.15` соответствует подключению Raspberry Pi.

Выполняем подключение по ssh:

```
$ ssh demo@10.0.0.15
Warning: Permanently added '10.0.0.15' (ECDSA) to the list of known hosts.
demo@10.0.0.15's password: 
 
 Welcome to ...
...
```

Просматриваем конфигурацию сетевого интерфейса на Raspberry Pi:

```
$ ifconfig eth0
eth0      Link encap:Ethernet  HWaddr B8:27:EB:3B:B2:97  
          inet addr:10.0.0.15  Bcast:10.0.0.255  Mask:255.255.255.0
          inet6 addr: fe80::ba27:ebff:fe3b:b297/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:24178 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7865 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:7637522 (7.2 MiB)  TX bytes:749911 (732.3 KiB)
```

Выполняем копирование файла Makefile с локального компьютера на Raspberry Pi в домашнюю директорию пользователя demo:

```
$ scp Makefile demo@10.0.0.15:~/
Warning: Permanently added '10.0.0.15' (ECDSA) to the list of known hosts.
demo@10.0.0.15's password: 
Makefile                                      100%   43KB   1.7MB/s   00:00
```
