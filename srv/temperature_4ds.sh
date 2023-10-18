#!/bin/bash
# Output to the log file
#cp /home/msa/digitemp/temperature.log /var/log/temperature.log

# Populate our database
#rrdtool update /var/db/rrdtool/temperature.rrd N:$temperatere

# Path to your log file
log_file="/home/admin/digitemp/temperature2.log"

# Path to your RRD file
rrd_file_out="/var/db/rrdtool/temperature.rrd"
rrd_file_in="/var/db/rrdtool/temperature_inside.rrd"
rrd_file_4ds="/var/db/rrdtool/temperature_4ds.rrd"

# Read each line from the log file
while IFS= read -r line; do
    # Extract temperature and timestamp from the line
    temp_out=$(echo "$line" | awk '{print $1}')
    temp_in=$(echo "$line" | awk '{print $2}')
    heat_transfer_in=$(echo "$line" | awk '{print $3}')
    heat_transfer_out=$(echo "$line" | awk '{print $4}')
    timestamp=$(echo "$line" | awk '{print $5}')

    # Convert timestamp to UNIX timestamp format
    # unix_timestamp=$(date -d "$timestamp" +"%s")

    # Update the RRD file with the temperature and timestamp
    rrdtool update "$rrd_file_out" "$timestamp:$temp_out"
    sleep 1
    rrdtool update "$rrd_file_in" "$timestamp:$temp_in"
    sleep 1
    rrdtool update "$rrd_file_4ds" "$timestamp:$temp_in:$temp_out:$heat_transfer_in:$heat_transfer_out"

done < "$log_file"

truncate -s 0 $log_file

sleep 5
/home/admin/digitemp/graphcreate_4ds.sh
