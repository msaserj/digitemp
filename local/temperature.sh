#!/bin/bash

# mapfile -t array <<< "$(digitemp_DS9097 -q -a -c /home/digitemp/.digitemprc | awk '{print $7}' | bc -l)"
mapfile -t array <<< "$(digitemp_DS9097 -q -a -c /home/digitemp/.digitemprc_c)"

date=`date "+%d.%m.%Y_%H:%M"`
timestamp=$(date +"%s")

# делаем вывод в лог-файл
echo ${array[@]} $date >> /home/digitemp/temperature.log
echo ${array[@]} $timestamp >> /home/digitemp/temperature2.log

#rrdtool update /var/db/rrdtool/temperature.rrd N:${array[0]}:${array[1]}
#echo ${array[0]}:${array[1]}
