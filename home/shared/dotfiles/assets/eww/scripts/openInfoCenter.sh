#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-info-center.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"

WINDOWS=("control-center" "notification-center" "statscreen" "info-center")

fix_stacking_bug() {
  xdo lower -a "Eww - bar"
  for window in "${WINDOWS[@]}"; do
    xdo lower -a "Eww - ${window}"
  done
}

run() {
	${EWW_BIN} open info-center
	sleep 0.2
  ${EWW_BIN} update icenter=true;
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
		rm "$LOCK_FILE"
		${EWW_BIN} update icenter=false
		sleep 0.6
		${EWW_BIN} close info-center
    fix_stacking_bug
	fi
fi
