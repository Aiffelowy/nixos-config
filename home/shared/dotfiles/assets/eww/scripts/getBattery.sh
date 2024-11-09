#!/bin/sh

# INTERNAL USE! Do not edit.
FAKE_BATTERY="0"

if [[ "$FAKE_BATTERY" -gt 0 ]]; then
	if [[ ! -f "$HOME/.cache/fake_battery_capacity" ]]; then
		echo $(($RANDOM % 100)) > "$HOME/.cache/fake_battery_capacity"
	fi
fi

case $1 in
	"icon")
		if [[ -d /sys/class/power_supply/ACAD ]]; then
			echo ""
		elif [[ -d /sys/class/power_supply/BAT0 ]]; then
			[[ $(cat /sys/class/power_supply/BAT0/status) == "Discharging" ]] && echo "" || echo ""
		else
			echo ""
		fi
		;;
	"capacity")
		if [[ "$FAKE_BATTERY" -gt 0 ]]; then
			if [[ -f "$HOME/.cache/fake_battery_capacity" ]]; then
				echo $(cat "$HOME/.cache/fake_battery_capacity")
			fi
		elif [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
			echo $(cat /sys/class/power_supply/BAT0/capacity)
        elif [[ ! -d /sys/class/power_supply/BAT0 ]]; then
            echo "100"
		fi
		;;

  "style")
		if [[ "$FAKE_BATTERY" -gt 0 ]]; then
      echo "high"
    elif [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]; then
      echo "charging"
		elif [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
			CAP=$(cat /sys/class/power_supply/BAT0/capacity)

      if [[ $CAP -lt 20 ]]; then
        echo "low"
      elif [[ $CAP -lt 40 ]]; then
        echo "mid"
      else
        echo "high"
      fi
		fi
		;;

esac
