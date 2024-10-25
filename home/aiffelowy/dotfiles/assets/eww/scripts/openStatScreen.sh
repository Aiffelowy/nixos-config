#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-statscreen.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/aiffelowy/dotfiles/assets/eww"

fix_stacking_bug() {
	for entry in $(xdotool search --pid $(pidof eww)); do
		xdo below -N eww-statscreen $entry
	done
}

run() {
	${EWW_BIN} open statscreen
	sleep 0.2
	fix_stacking_bug; ${EWW_BIN} update stscrn=true; xdo raise -a "Eww - bar"
	touch "$LOCK_FILE"
}

if [[ ! `pidof eww` ]]; then
	${EWW_BIN} daemon
	sleep 1
else
	if [[ ! -f "$LOCK_FILE" ]]; then
		run
	else
		rm "$LOCK_FILE"
		${EWW_BIN} update stscrn=false
		sleep 0.6
		${EWW_BIN} close statscreen
		xdo lower -a "Eww - bar"
	fi
fi
