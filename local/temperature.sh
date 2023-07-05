#!/bin/bash

line=`digitemp_DS9097 -q -a -c /home/digitemp/.digitemprc`

temp=$(echo "$line" | awk '{print $7}' | bc -l)

date=`date "+%d.%m.%Y_%H:%M"`
timestamp=$(date +"%s")

echo "$temp" "$date" >> /home/digitemp/temperature.log

echo "$temp" "$timestamp" >> /home/digitemp/temperature2.log
