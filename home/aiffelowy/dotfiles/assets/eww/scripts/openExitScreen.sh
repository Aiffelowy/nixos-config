#!/bin/sh

LOCK_FILE="$HOME/.cache/eww-escreen.lock"
HIDE_LOCK="$HOME/.cache/hidden.lock"
EWW_BIN="eww --config $HOME/.config/nixos/home/aiffelowy/dotfiles/assets/eww"

hide_unhide_windows() {
  if [[ ! -f "$HIDE_LOCK" ]]; then
    while bspc node 'any.!hidden.window' -g hidden=on; do false; done
    touch "$HIDE_LOCK"
  else
	  while bspc node any.hidden.window -g hidden=off; do false; done
    rm "$HIDE_LOCK"
  fi
}

re_run() {
	if [[ ! -f "$HOME/.cache/bar.lck" ]]; then
		$HOME/.config/nixos/home/aiffelowy/dotfiles/assets/localbin/tglbar
	fi
	
	${EWW_BIN} update escreen=true
}

run() {
	$HOME/.config/nixos/home/aiffelowy/dotfiles/assets/localbin/tglbar
	${EWW_BIN} open exit-screen
	sleep 0.2 && hide_unhide_windows; sleep 0.2 && ${EWW_BIN} update escreen=true

	# Sometimes, eww is a dick. It doesn't update the exitscreen properly.
	sleep 0.2 && re_run
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
	${EWW_BIN} daemon
	sleep 1
else
	if [[ ! -f "$LOCK_FILE" ]]; then
		touch "$LOCK_FILE"
		$HOME/.config/nixos/home/aiffelowy/dotfiles/assets/localbin/termeww
    run
	else
		sleep 0.15 && ${EWW_BIN} update escreen=false
		sleep 0.2 && hide_unhide_windows
	  $HOME/.config/nixos/home/aiffelowy/dotfiles/assets/localbin/tglbar
		${EWW_BIN} close exit-screen
		rm "$LOCK_FILE"
	fi
fi
