before_fmt "(eventbox :onscroll \"sh $HOME/.config/nixos/home/shared/dotfiles/assets/eww/scripts/dashActions.sh '{}'\" :valign \"center\" (box	:class \"ws\" :orientation \"h\"	:halign \"center\"	:valign \"center\"	 :space-evenly \"true\" "

## available fmt values: desktop, focused, occupied, reversed, icon
fmt "(button :onclick \"bspc desktop -f {desktop}\" :style \"color: {color}\"	:class	\"{focused} {occupied} {reversed}\" \"{icon}\")"

after_fmt "))"

title "nvim.*"   color #32CD32 focused_color #a3d530 reversed
title ".*Reddit.*" 
title ".*Stack Overflow.*" 
title ".*YouTube.*" 
class "firefox"   color #ff7900  focused_color #bf5700 reversed
class "discord"   color #B65fcf  focused_color #7A5988  reversed
class "steam" 
class "kitty"   reversed
class "mpv"  reversed
class "steam_app*" 󰊗

empty   color #0b0f10
default   color #0b0f10 focused_color #b7b8b8

