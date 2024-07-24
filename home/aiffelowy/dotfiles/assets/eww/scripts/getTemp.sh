#!/bin/sh

TEMP=$(paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | grep acpitz | awk '{print $2}')

case "$1" in
  "temp")
    echo $TEMP | sed 's/\(.\)...$/\1°C/'
  ;;
  "icon")
    if [[ $TEMP -le 45000 ]]; then
      echo 
    elif [[ $TEMP -le 75000 ]]; then
      echo 
    elif [[ $TEMP -le 90000 ]]; then
      echo 
    else
      echo 
    fi
  ;;
esac
