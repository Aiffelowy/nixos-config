#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-wscreen.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"


hide_unhide_windows() {
	false
  #while bspc node any.hidden.window -g hidden=off; do false; done && while bspc node 'any.!hidden.window' -g hidden=on; do :; done
}

re_run() {
	${EWW_BIN} update wscreen=true
}

run() {
  maim -qu "$HOME/.cache/eww-wscreen.png"
  convert -scale 10% -blur 0x2.5 -resize 1000% "$HOME/.cache/eww-wscreen.png" "$HOME/.cache/eww-wscreen-b.png"
  feh -F --class "blur_background" "$HOME/.cache/eww-wscreen-b.png"
  ${EWW_BIN} update warning="${1}"
	${EWW_BIN} open warning-screen
	sleep 0.2 && hide_unhide_windows; sleep 0.2 && ${EWW_BIN} update wscreen=true

	# Sometimes, eww is a dick. It doesn't update the exitscreen properly.
	sleep 0.2 && re_run
}

if [[ ! `pidof eww` ]]; then
	${EWW_BIN} daemon
	sleep 1
else
	if [[ ! -f "$LOCK_FILE" ]]; then
		touch "$LOCK_FILE"
		$HOME/.config/nixos/home/shared/dotfiles/assets/localbin/termeww
    run "${1}"
	else
		sleep 0.15 && ${EWW_BIN} update wscreen=false
		sleep 0.2 && hide_unhide_windows
		${EWW_BIN} close warning-screen
		rm "$LOCK_FILE"
	fi
fi
