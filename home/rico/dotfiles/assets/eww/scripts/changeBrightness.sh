#!/bin/sh

EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"

b=$(bc <<< "scale=2; $1/100")
xrandr --output DP-2 --brightness $b --output HDMI-0 --brightness $b --output HDMI-1 --brightness $b
${EWW_BIN} update brightness=$1
