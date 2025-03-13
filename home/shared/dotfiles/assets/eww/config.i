before_fmt "(eventbox :onscroll \"sh $HOME/.config/nixos/home/shared/dotfiles/assets/eww/scripts/dashActions.sh '{}'\" :valign \"center\" (box	:class \"ws\" :orientation \"h\"	:halign \"center\"	:valign \"center\"	 :space-evenly \"true\" "

## available fmt values: desktop, focused, occupied, reversed, icon
fmt "(button :onclick \"bspc desktop -f {desktop}\" :style \"color: {color}; {size}\"	:class	\"{focused} {occupied} {reversed}\" \"{icon}\")"

after_fmt "))"

title "nvim.*"   
title ".*Reddit.*" 
title ".*Stack Overflow.*"  reversed
title ".*YouTube.*" 
class "firefox"   
class "discord"   
class "Spotify"  
class "steam" 󰓓 size "font-size: 1.2em; margin: 0 .2em 0 .5em;"
class "kitty"   reversed size "margin: 0;"
class "mpv"  reversed
class "steam_app.*" 󰊗
class "Godot" 
class "Blender" 󰂫
class ".*Minecraft.*" 󰍳
class "cs2" 󰆣 reversed size "font-size: 1.2em; margin: 0 .2em 0 .5em"

empty   color #0b0f10
default   color #0b0f10 focused_color #b7b8b8 size ";"

