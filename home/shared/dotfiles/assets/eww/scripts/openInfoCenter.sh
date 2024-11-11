#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-info-center.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"

fix_stacking_bug() {
	for entry in $(xdotool search --pid $(pidof eww)); do
		xdo below -N eww-control-panel $entry
	done
}

run() {
	${EWW_BIN} open info-center
	xdo raise -a "Eww - bar"
	sleep 0.2
	fix_stacking_bug; ${EWW_BIN} update icenter=true;
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
	${EWW_BIN} daemon
	sleep 1
else
	if [[ ! -f "$LOCK_FILE" ]]; then
		touch "$LOCK_FILE"
		run
	else
		rm "$LOCK_FILE"
		${EWW_BIN} update icenter=false
		sleep 0.6
		${EWW_BIN} close info-center
		xdo lower -a "Eww - bar"
	fi
fi
