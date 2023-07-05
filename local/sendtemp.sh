#!/bin/bash

source_file="/home/digitemp/temperature2.log"
target_folder="msaserj:/home/msa/digitemp/"

scp  "$source_file" "$target_folder"
truncate -s 0 $source_file

if [ $? -eq 0 ]; then
    echo "Файл успешно скопирован."
else
    echo "Ошибка при копировании."
fi

