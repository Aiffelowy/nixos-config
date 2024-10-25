#!/bin/sh

case $1 in
	"icon")
		[[ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]] && echo "" || echo ""
		;;
	"status")
		if [[ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]]; then
      echo "Off"
    else
      DEV=$(bluetoothctl devices Connected | head | cut -d " " -f3-)
      [[ -z "${DEV}" ]] && hostname || echo "${DEV:0:12}"
    fi
    ;;
	"supported")
		[[ ! -z $(lsusb | grep "Bluetooth") ]] && echo true || echo false
		;;
esac
