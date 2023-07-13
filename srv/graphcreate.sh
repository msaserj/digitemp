#!/bin/bash

# Path to your RRD file
rrd_file="/var/db/rrdtool/temperature.rrd"
rrd_file1="/var/db/rrdtool/temperature_inside.rrd"

# Path to save the graph image
graph_3h="/home/msa/digitemp/site/graph3h.png"
graph_12h="/home/msa/digitemp/site/graph12h.png"
graph_24h="/home/msa/digitemp/site/graph24h.png"
graph_7d="/home/msa/digitemp/site/graph7d.png"

# Start time for the graph (24 hours ago)
start_3h="-3h"
start_12h="-12h"
start_24h="-24h"
start_7d="end-1w"

# End time for the graph (now)
end="now"

# Graph parameters
width="800"                            # Width of the graph in pixels
height="400"                           # Height of the graph in pixels
title="Temperature Graph 3 hours"      # Title of the graph
title12="Temperature Graph 12 hours"   # Title of the graph
title24="Temperature Graph 24 hours"   # Title of the graph
title7d="Temperature Graph Last week"  # Title of the graph
vertical_label="Temperature (Celsius)" # Y-axis label

# Function to create the graph using rrdtool graph
create_graph() {
  local graph_file="$1"
  local start_time="$2"
  local title="$3"

  rrdtool graph "$graph_file" \
    --start "$start_time" \
    --end "$end" \
    --width "$width" \
    --height "$height" \
    --font DEFAULT:14 \
    --font TITLE:24 \
    --font AXIS:10 \
    --y-grid 1:2 \
    --color BACK#444444 \
    --color SHADEA#444444 \
    --color SHADEB#444444 \
    --color CANVAS#444444 \
    --color FONT#ff7518 \
    --slope-mode \
    --units-exponent 0 \
    --title "$title" \
    --vertical-label "$vertical_label" \
    DEF:temperature="$rrd_file":temperature:AVERAGE \
    LINE3:temperature#00FF00:"Temperature" \
    CDEF:tp_17=temperature,0,GT,temperature,100,GT,34,temperature,IF,0,IF AREA:tp_17#FF0000 \
    CDEF:tp_16=temperature,0,GT,temperature,32,GT,32,temperature,IF,0,IF AREA:tp_16#FF1100 \
    CDEF:tp_15=temperature,0,GT,temperature,30,GT,30,temperature,IF,0,IF AREA:tp_15#FF2200 \
    CDEF:tp_14=temperature,0,GT,temperature,28,GT,28,temperature,IF,0,IF AREA:tp_14#FF3300 \
    CDEF:tp_13=temperature,0,GT,temperature,26,GT,26,temperature,IF,0,IF AREA:tp_13#FF4400 \
    CDEF:tp_12=temperature,0,GT,temperature,24,GT,24,temperature,IF,0,IF AREA:tp_12#FF5500 \
    CDEF:tp_11=temperature,0,GT,temperature,22,GT,22,temperature,IF,0,IF AREA:tp_11#FF6600 \
    CDEF:tp_10=temperature,0,GT,temperature,20,GT,20,temperature,IF,0,IF AREA:tp_10#FF7700 \
    CDEF:tp_09=temperature,0,GT,temperature,18,GT,18,temperature,IF,0,IF AREA:tp_09#FF8800 \
    CDEF:tp_08=temperature,0,GT,temperature,16,GT,16,temperature,IF,0,IF AREA:tp_08#FF9900 \
    CDEF:tp_07=temperature,0,GT,temperature,14,GT,14,temperature,IF,0,IF AREA:tp_07#FFAA00 \
    CDEF:tp_06=temperature,0,GT,temperature,12,GT,12,temperature,IF,0,IF AREA:tp_06#FFBB00 \
    CDEF:tp_05=temperature,0,GT,temperature,10,GT,10,temperature,IF,0,IF AREA:tp_05#FFCC00 \
    CDEF:tp_04=temperature,0,GT,temperature,8,GT,8,temperature,IF,0,IF AREA:tp_04#FFDD00 \
    CDEF:tp_03=temperature,0,GT,temperature,6,GT,6,temperature,IF,0,IF AREA:tp_03#FFEE00 \
    CDEF:tp_02=temperature,0,GT,temperature,4,GT,4,temperature,IF,0,IF AREA:tp_02#FFFF00 \
    CDEF:tp_01=temperature,0,GT,temperature,2,GT,2,temperature,IF,0,IF AREA:tp_01#ffff00 \
    CDEF:tm_17=temperature,0,LT,temperature,-100,LT,-34,temperature,IF,0,IF AREA:tm_17#0000FF \
    CDEF:tm_16=temperature,0,LT,temperature,-32,LT,-32,temperature,IF,0,IF AREA:tm_16#0011FF \
    CDEF:tm_15=temperature,0,LT,temperature,-30,LT,-30,temperature,IF,0,IF AREA:tm_15#0022FF \
    CDEF:tm_14=temperature,0,LT,temperature,-28,LT,-28,temperature,IF,0,IF AREA:tm_14#0033FF \
    CDEF:tm_13=temperature,0,LT,temperature,-26,LT,-26,temperature,IF,0,IF AREA:tm_13#0044FF \
    CDEF:tm_12=temperature,0,LT,temperature,-24,LT,-24,temperature,IF,0,IF AREA:tm_12#0055FF \
    CDEF:tm_11=temperature,0,LT,temperature,-22,LT,-22,temperature,IF,0,IF AREA:tm_11#0066FF \
    CDEF:tm_10=temperature,0,LT,temperature,-20,LT,-20,temperature,IF,0,IF AREA:tm_10#0077FF \
    CDEF:tm_09=temperature,0,LT,temperature,-18,LT,-18,temperature,IF,0,IF AREA:tm_09#0088FF \
    CDEF:tm_08=temperature,0,LT,temperature,-16,LT,-16,temperature,IF,0,IF AREA:tm_08#0099FF \
    CDEF:tm_07=temperature,0,LT,temperature,-14,LT,-14,temperature,IF,0,IF AREA:tm_07#00AAFF \
    CDEF:tm_06=temperature,0,LT,temperature,-12,LT,-12,temperature,IF,0,IF AREA:tm_06#00BBFF \
    CDEF:tm_05=temperature,0,LT,temperature,-10,LT,-10,temperature,IF,0,IF AREA:tm_05#00CCFF \
    CDEF:tm_04=temperature,0,LT,temperature,-8,LT,-8,temperature,IF,0,IF AREA:tm_04#00DDFF \
    CDEF:tm_03=temperature,0,LT,temperature,-6,LT,-6,temperature,IF,0,IF AREA:tm_03#00EEFF \
    CDEF:tm_02=temperature,0,LT,temperature,-4,LT,-4,temperature,IF,0,IF AREA:tm_02#00FFFF \
    CDEF:tm_01=temperature,0,LT,temperature,-2,LT,-2,temperature,IF,0,IF AREA:tm_01#CDFFFF \
    DEF:temp="$rrd_file1":temp:AVERAGE \
    LINE2:temp#004DFF:"Inside tC" \
    GPRINT:temperature:AVERAGE:"Average\: %3.2lfC" \
    GPRINT:temperature:MIN:"MIN\: %3.2lfC" \
    GPRINT:temperature:MAX:"MAX\: %3.2lfC" \
    GPRINT:temperature:LAST:"Current\: %3.2lfC"
}

# Create the graphs
create_graph "$graph_3h" "$start_3h" "$title"
sleep 1
create_graph "$graph_12h" "$start_12h" "$title12"
sleep 1
create_graph "$graph_24h" "$start_24h" "$title24"
sleep 1
create_graph "$graph_7d" "$start_7d" "$title7d"


