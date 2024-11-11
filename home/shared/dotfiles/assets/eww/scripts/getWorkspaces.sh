#!/bin/sh

workspaces() {
  string="(eventbox :onscroll \"sh $HOME/.config/nixos/home/shared/dotfiles/assets/eww/scripts/dashActions.sh '{}'\" :valign \"center\" (box	:class \"ws\" :orientation \"h\"	:halign \"center\"	:valign \"center\"	 :space-evenly \"false\" :spacing \"-5\""
  focused_node=$(bspc query -D -d focused --names)
  for workspace in $*; do
    string+="(button :onclick \"bspc desktop -f $workspace\"	:class	\"a$(bspc query -D -d .occupied --names | grep $workspace)$([[ $focused_node -eq $workspace ]] && echo $workspace)\"	\"$([[ $focused_node -eq $workspace ]] && echo "◆" || echo "◇")\")"
  done

  string+="))"
  echo $string
}


workspaces $*
bspc subscribe desktop node_transfer | while read -r _; do
  workspaces $*
done
