#!/bin/sh

BAT="BAT0"
AC="AC0"

case $1 in
  "power")
    WATTS=$(cat /sys/class/power_supply/$BAT/power_now)
    echo $(bc <<< "scale=2; ${WATTS}/1000000")"W"
    ;;

  "icon")
    grep -q 1 /sys/class/power_supply/$AC/online && echo power || echo bolt
    ;;
esac



