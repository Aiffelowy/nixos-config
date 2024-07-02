let 
  	homedir = "/home/aiffelowy";
		localbin = "${homedir}/.local/bin";
		ewwscripts = "${homedir}/.config/eww/scripts";
		sxhkdscripts = "${homedir}/.config/sxhkd/scripts";
in
{
  services.sxhkd = {
				enable = true;
				keybindings = {
					"super + shift + {w, f}" = "{firefox,thunar}";
					"ctrl + alt + t" = "kitty";
					"super + p" = "${localbin}/appmnu";
					"ctrl + alt + l" = "${localbin}/lck";
					"super + shift + {d,c}" = "${ewwscripts}/openControlCenter.sh";
					"super + shift + n" = "${ewwscripts}/openNotificationCenter.sh";
					"super + shift + i" = "${ewwscripts}/openInfoCenter.sh";
					"super + shift + b" = "${localbin}/tglbar";
					"super + Escape" = "${ewwscripts}/openExitScreen.sh";
					"~Escape" = "[[ -f \"${homedir}/.cache/eww-escreen.lock\" ]] && ${ewwscripts}/openExitScreen.sh";
					"XF86Audio{Raise,Lower}Volume" = "amixer -q set Master 5%{+,-}";
					"XF86AudioMute" = "${sxhkdscripts}/audioToggle.sh";
					"XF86MonBrightness{Up,Down}" = "brightnessctl set 5%{+,-}";
					"super + shift + s" = "maim -us \"${homedir}/.ss.png\"; ${localbin}{viewscr,upldscr} ${homedir}.ss.png";
					"super + {_,shift +}Tab" = "bspc node -f {prev,next}.local.!hidden.window";
					"super + {Up, Down, Left, Right}" = "${sxhkdscripts}/bselect.sh {north, south, west, east}";
					"super + shift + {Up, Down, Left, Right}" = "${sxhkdscripts}/bsmove.sh {north, south, west, east}";
					"super + c" = "bspc node -c";
					"alt + F4" = "bspc node -k";
					"super + {_,shift + }{1-5}" = "bspc {desktop -f, node -d} '^{1-5}'";
					"super + {t,shift + t,space,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
					"super + ctrl + r" = "pkill -USR1 sxhkd; notify-send \"sxhkd\" \"Restarted Simple X hotkey daemon\"";
				};
			};

}
