#!/bin/sh

TEMP=$(paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | grep $1 | awk '{print $2}')

if [[ $TEMP -le 45000 ]]; then
  echo 
elif [[ $TEMP -le 75000 ]]; then
  echo 
elif [[ $TEMP -le 90000 ]]; then
  echo 
else
  echo 
fi

