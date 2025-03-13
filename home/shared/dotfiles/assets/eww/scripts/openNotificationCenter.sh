#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-notification-center.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"

WINDOWS=("control-center" "notification-center" "statscreen" "info-center")

fix_stacking_bug() {
#	for entry in $(xdotool search --pid $(pidof eww)); do
#		xdo below -a "Eww - notification-center" -t $entry
#	done
  xdo lower -a "Eww - bar"
  for window in "${WINDOWS[@]}"; do
    xdo lower -a "Eww - ${window}"
  done
}

run() {
	${EWW_BIN} open notification-center
	sleep 0.2
	${EWW_BIN} update noticenter=true
  xdo raise -a "Eww - bar"
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
		${EWW_BIN} update noticenter=false
		sleep 0.8
		${EWW_BIN} close notification-center
		rm "$LOCK_FILE"
    fix_stacking_bug
	fi
fi
