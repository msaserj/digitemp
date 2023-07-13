#!/bin/bash

# Path to your log file
log_file="/home/msa/digitemp/temperature2.log"

# Path to your RRD file
rrd_file="/var/db/rrdtool/temperature.rrd"
rrd_file1="/var/db/rrdtool/temperature_inside.rrd"
rrd_file_new="/var/db/rrdtool/temperature_new.rrd"

# Read each line from the log file
while IFS= read -r line; do
    # Extract temperature and timestamp from the line
    temp0=$(echo "$line" | awk '{print $1}')
    temp1=$(echo "$line" | awk '{print $2}')

    timestamp=$(echo "$line" | awk '{print $3}')

    # Convert timestamp to UNIX timestamp format
    # unix_timestamp=$(date -d "$timestamp" +"%s")

    # Update the RRD file with the temperature and timestamp
    rrdtool update "$rrd_file" "$timestamp:$temp0"
    sleep 1
    rrdtool update "$rrd_file1" "$timestamp:$temp1"
    sleep 1
    rrdtool update "$rrd_file_new" "$timestamp:$temp0:$temp1"

done < "$log_file"

truncate -s 0 $log_file
sleep 5
/home/msa/digitemp/graphcreate1.sh
