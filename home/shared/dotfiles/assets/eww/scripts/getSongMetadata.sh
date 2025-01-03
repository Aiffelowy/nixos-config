#!/bin/sh

PLAYERS="spotify,%any,firefox,chromium,brave,mpd"
ARTIST=$(playerctl -p $PLAYERS metadata --format '{{ artist }}')
TITLE=$(playerctl -p $PLAYERS metadata --format '{{ title }}')
STATUS=$(playerctl -p $PLAYERS status)

EWW_BIN="eww --config $HOME/.config/nixos/home/$USER/dotfiles/assets/eww"

artist() {
	# Check if $title is "Advertisement" cause fuck Spotify.
	# Deathemonic: How about using a spicetify adblocker (The Easy Way) or a adblock script https://github.com/abba23/spotify-adblock (The Chad Way) 
	# Kizu: https://github.com/abba23/spotify-adblock to big to clone for my wifi lmao
	if [[ "$TITLE" = "Advertisement" ]]; then
		echo "Spotify Free"
	else
		[[ -z "$ARTIST" ]] && echo "Unknown Artist" || echo "by $ARTIST"
	fi
}

title() {
	if [[ -z "$TITLE" ]]; then
		echo "Nothing Playing"
		
		[[ -f "$HOME/.cache/eww-control-center.lock" ]] && $EWW_BIN update mp=false
	else
		# Eww can't truncate Japanese and Chinese characters.
		if [[ "$TITLE" =~ ^[一-龠]+|[ぁ-ゔ]+|[ァ-ヴー]+ ]]; then
			[[ ${#TITLE} -gt 16 ]] && echo ${TITLE::10}... || echo $TITLE
		else
			echo $TITLE
		fi

		[[ -f "$HOME/.cache/eww-control-center.lock" ]] && $EWW_BIN update mp=true
	fi
}

player_status() {
	if [[ "$STATUS" = "Playing" ]]; then
		echo ""
	elif [[ "$STATUS" = "Paused" ]]; then
		echo ""
	else
		echo ""
	fi
}

player_status_text() {
	# Author Notes:
	# Deathemonic: It checks for the first priority player name and removes the rest of the players. This is usefull when spotify and mpd are both running

	PLAYER_NAME=$(playerctl -p $PLAYERS -l | head -n 1)
	# Some browsers sometimes have ".instance(RANDOM_STRING)" in their names like Firefox. This removes the instance name.
	PLAYER_NAME_SPLIT=($(echo $PLAYER_NAME | tr "." "\n"))
	PLAYER_NAME_SPLIT=${PLAYER_NAME_SPLIT[0]}

	[[ "$STATUS" = "Playing" ]] && echo "Now Playing - via ${PLAYER_NAME_SPLIT^}" || echo "Music"
}

position() {
	POSITION=$(playerctl -p $PLAYERS position | sed 's/..\{6\}$//')
	DURATION=$(playerctl -p $PLAYERS metadata mpris:length | sed 's/.\{6\}$//')
	
	# Author Notes:
	# Deathemonic: It check if the position is greater than 0 then execute the position if not just echo a empty space
	# Why do this? Because playerctl can't detect position on some players like firefox and spotify, and instead of manually modifying the script it just detects
	if [[ $POSITION -gt 0 ]]; then
		printf "%0d:%02d" $((POSITION % 3600 / 60)) $((POSITION % 60))
		printf " / "
		printf "%0d:%02d" $((DURATION % 3600 / 60)) $((DURATION % 60))
	else
		echo ""
	fi
}

case $1 in
	"artist") artist;;
	"title") title;;
	"player_status") player_status;;
	"player_status_text") player_status_text;;
	"position") position;;
esac
