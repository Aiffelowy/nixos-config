#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-control-center.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"
ACTIVE_PLAYERS=$(playerctl -l | head -n 1)

WINDOWS=("control-center" "notification-center" "statscreen" "info-center")

fix_stacking_bug() {
#  for entry in $(xdotool search --class eww ); do
#    false
#		xdo below -a "Eww - control-center" -t $entry
#	done
#  xdo lower -a "Eww - control-center"
  xdo lower -a "Eww - bar"
  for window in "${WINDOWS[@]}"; do
    xdo lower -a "Eww - ${window}"
  done
}

run() {
	${EWW_BIN} open control-center
	sleep 0.2
  ${EWW_BIN} update ccenter=true

	sleep 0.8 && [[ ! -z "$ACTIVE_PLAYERS" ]] && ${EWW_BIN} update mp=true
	touch "$LOCK_FILE"
  xdo raise -a "Eww - bar"
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
	${EWW_BIN} daemon
	sleep 1
else
	if [[ ! -f "$LOCK_FILE" ]]; then
		run
	else
		rm "$LOCK_FILE"
		[[ ! -z "$ACTIVE_PLAYERS" ]] && ${EWW_BIN} update mp=false && sleep 0.4
		${EWW_BIN} update ccenter=false
		sleep 0.6
		${EWW_BIN} close control-center
    fix_stacking_bug
	fi
fi
