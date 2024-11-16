#!/bin/sh

get_icon() {
  nodes=$(bspc query -d $1 -N -n .window)
  [[ -z $nodes ]] && { [[ $1 -eq $2 ]] && echo ◆ || echo ◇; exit; }

  case `xprop -id "$nodes" WM_CLASS | cut -d\" -f4` in
    firefox) echo 󰈹
    ;;
    kitty) echo 
    ;;
    discord) echo 
    ;;
    Spotify) echo 
    ;;
    Steam) echo 
    ;;
    *) [[ $1 -eq $2 ]] && echo ◆ || echo ◇
    ;;
  esac
}

get_icon_old() {
  [[ $1 -eq $2 ]] && echo ◆ || echo ◇
}

workspaces() {
  string="(eventbox :onscroll \"sh $HOME/.config/nixos/home/shared/dotfiles/assets/eww/scripts/dashActions.sh '{}'\" :valign \"center\" (box	:class \"ws\" :orientation \"h\"	:halign \"center\"	:valign \"center\"	 :space-evenly \"false\" :spacing \"-5\""
  focused_node=$(bspc query -D -d focused --names)
  for workspace in $*; do
    string+="(button :onclick \"bspc desktop -f $workspace\"	:class	\"a$(bspc query -D -d .occupied --names | grep $workspace)$([[ $focused_node -eq $workspace ]] && echo $workspace)\"	\"$(get_icon_old $workspace $focused_node)\")"
  done

  string+="))"
  echo $string
}


workspaces $*
bspc subscribe desktop node_transfer | while read -r _; do
  workspaces $*
done
