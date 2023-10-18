#!/bin/bash

# Путь к устройству /dev/ttyUSB0
usb_device="/dev/ttyUSB0"

# Проверяем наличие устройства
if [ -e "$usb_device" ]; then
    # создаем массив с нужными температурами
    mapfile -t array <<< "$(digitemp_DS9097 -q -a -c /home/digitemp/.digitemprc_4ds)"

    # определяем текущую дату для вывода в лог
    date=$(date "+%d.%m.%Y_%H:%M")
    timestamp=$(date +"%s")

    # делаем вывод в лог-файл
    echo "${array[@]} $timestamp" >> /home/digitemp/temperature2.log

    sleep 6

    /home/digitemp/sendtemp.sh
    echo "${date} Записано ${array[@]} ${timestamp}"
    echo "========================================"
else
    echo "${date} Устройство ${usb_device} не обнаружено. Скрипт не выполняется."
fi
