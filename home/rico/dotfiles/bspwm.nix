let
  homedir = "/home/rico";
	bspwmdir = "${homedir}/.config/nixos/home/shared/dotfiles/assets/bspwm";
	wallpaper = "${bspwmdir}/assets/wallpaper.png";
in
{
  xsession.windowManager.bspwm = {
		enable = true;
		
		monitors = {
			HDMI-0 = [ "1" "2" ];
      HDMI-1 = [ "6" "7" ];
      DP-2 = [ "3" "4" "5" ];
		};

		settings = {
pointer_modifier = "Mod4";
			window_gap = 12;
			top_padding = 0;
			left_padding = 0;
			right_padding = 0;
			bottom_padding = 48;

			split_ratio = 0.5;
			borderless_monocle = true;
			gapless_monocle = true;
		};

		rules = {
			"Viewnoir" = {
				state = "floating";
			};
      "iwgtk" = {
        state = "floating";
      };
      ".blueman-manager-wrapped" = {
        state = "floating";
      };
      "discord" = {
        desktop = "^6";
      };
      "steam" = {
        desktop = "^6";
      };
		};
		
		startupPrograms = [
			"sxhkd"
			"picom"
			"${bspwmdir}/scripts/idle.sh"
			"eww --config ${homedir}/.config/nixos/home/rico/dotfiles/assets/eww daemon"
			"${bspwmdir}/scripts/ewwFullscreenFix.sh"
			"${bspwmdir}/scripts/persistentQuickUtilities.sh"
			"exec mpd"
			"exec mpDris2"
			"xdo lower -a \"Eww - bar\""
			"eww --config ${homedir}/.config/nixos/home/rico/dotfiles/assets/eww open bar"
			"eww --config ${homedir}/.config/nixos/home/rico/dotfiles/assets/eww open bar-left"
			"eww --config ${homedir}/.config/nixos/home/rico/dotfiles/assets/eww open bar-right"

		];

		extraConfigEarly = ''
      xrandr --output DP-2 --primary --mode 2560x1440 --output HDMI-0 --mode 1920x1080 --left-of DP-2 --output HDMI-1 --mode 1920x1080 --right-of DP-2 --rotate right
			rm ${homedir}/.cache/dunst.log
			rm ${homedir}/.cache/fake_battery_capacity
			rm ${homedir}/.cache/eww-calendar.lock
			rm ${homedir}/.cache/escreen.lock
			rm ${homedir}/.cache/eww-control-center.lock
			rm -r ${homedir}/.cache/dunst

			pkill ewwFullscreenFix.sh
			pkill persistentQuickUtilities.sh
			pkill sxhkd
		'';

		extraConfig = ''
			xsetroot -cursor_name left_ptr &
			hsetroot -fill "${wallpaper}"
			xset m 0 0
		'';
	};
}
