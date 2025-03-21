let 
    homedir = "~";
		localbin = "${homedir}/.config/nixos/home/shared/dotfiles/assets/localbin";
		ewwscripts = "${homedir}/.config/nixos/home/shared/dotfiles/assets/eww/scripts";
		sxhkdscripts = "${homedir}/.config/nixos/home/shared/dotfiles/assets/sxhkd";
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
					"XF86Audio{Raise,Lower}Volume" = "${localbin}/chng-volume {+,-}";
					"XF86AudioMute" = "${sxhkdscripts}/audioToggle.sh";
					"XF86MonBrightness{Up,Down}" = "${localbin}/chng-brightness {+,-}";
					"super + shift + s" = "maim -us ${homedir}/.ss.png; ${localbin}/viewscr ${homedir}/.ss.png";
					"super + {_,shift +}Tab" = "bspc node -f {prev,next}.local.!hidden.window";
					"super + {Up, Down, Left, Right}" = "${sxhkdscripts}/bselect.sh {north, south, west, east}";
					"super + shift + {Up, Down, Left, Right}" = "${sxhkdscripts}/bsmove.sh {north, south, west, east}";
					"super + c" = "bspc node -c";
					"alt + F4" = "bspc node -k";
					"super + {_,shift + }{1-7}" = "bspc {desktop -f, node -d} '^{1-7}'";
					"super + {t,shift + t,space,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
					"super + ctrl + r" = "pkill -USR1 sxhkd; notify-send \"sxhkd\" \"Restarted Simple X hotkey daemon\"";
          "XF86Launch1" = "asusctl --next-kbd-bright";
          "ctrl + alt + y" = "/home/aiffelowy/builds/scripts/funny";
				};
			};

}
