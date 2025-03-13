#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-statscreen.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"

WINDOWS=("control-center" "notification-center" "statscreen" "info-center")

fix_stacking_bug() {
#	for entry in $(xdotool search --pid $(pidof eww)); do
#		xdo below -a "Eww - statscreen" -t $entry
#	done
  xdo lower -a "Eww - bar"
  for window in "${WINDOWS[@]}"; do
    xdo lower -a "Eww - ${window}"
  done

}

run() {
	${EWW_BIN} open statscreen
	sleep 0.2
  ${EWW_BIN} update stscrn=true
	touch "$LOCK_FILE"
  xdo raise -a "Eww - bar"
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
    fix_stacking_bug
	fi
fi
