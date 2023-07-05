#!/bin/bash

log_file="/home/msa/digitemp/temperature2.log"
rrd_file="/var/db/rrdtool/temperature.rrd"

# Read each line from the log file
while IFS= read -r line; do
    temperature=$(echo "$line" | awk '{print $1}')
    timestamp=$(echo "$line" | awk '{print $2}')

    # Update the RRD file with the temperature and timestamp
    rrdtool update "$rrd_file" "$timestamp:$temperature"
done < "$log_file"

truncate -s 0 $log_file
sleep 5
/home/msa/digitemp/graphcreate1.sh
