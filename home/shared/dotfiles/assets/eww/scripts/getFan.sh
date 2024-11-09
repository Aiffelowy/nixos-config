#!/bin/sh


FAN_HWMON="/sys/devices/platform/asus-nb-wmi/hwmon/hwmon5"
cat "${FAN_HWMON}/fan${1}_input"


