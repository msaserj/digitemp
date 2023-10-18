#!/bin/bash

#scp "/home/digitemp/temperature2.log" "msaserj:/home/admin/digitemp/"

# Указываем путь к исходному файлу на локальном компьютере
source_file="/home/digitemp/temperature2.log"

# Указываем путь к целевой папке на удаленном компьютере
target_folder="msaserj:/home/admin/digitemp/"


# Копируем файл на удаленный компьютер
scp  "$source_file" "$target_folder"

truncate -s 0 $source_file

# сделаем время и дату
date=$(date "+%d.%m.%Y_%H:%M")

# Проверяем успешность копирования
if [ $? -eq 0 ]; then
    echo "${date} Файл успешно скопирован на удаленный компьютер."
else
    echo "${date} Ошибка при копировании файла на удаленный компьютер."
fi

