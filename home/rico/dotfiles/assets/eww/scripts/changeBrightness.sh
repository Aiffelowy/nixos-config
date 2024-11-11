#!/bin/sh


b=$(bc <<< "scale=2; $1/100")
xrandr --output DP-2 --brightness $b --output HDMI-0 --brightness $b --output HDMI-1 --brightness $b
