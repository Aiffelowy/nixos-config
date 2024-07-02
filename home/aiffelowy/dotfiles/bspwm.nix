let
  homedir = "/home/aiffelowy";
	bspwmdir = "${homedir}/.config/bspwm";
	wallpaper = "${bspwmdir}/assets/wallpaper.png";
in
{
  xsession.windowManager.bspwm = {
		enable = true;
		
		monitors = {
			eDP = [ "1" "2" "3" "4" "5" ];
		};

		settings = {
			pointer_modifier = "Mod4";
			window_gap = 16;
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
		};
		
		startupPrograms = [
			"sxhkd"
			"picom"
			"${homedir}/.config/bspwm/scripts/idle.sh"
			"eww"
			"${bspwmdir}/scripts/ewwFullscreenFix.sh"
			"${bspwmdir}/scripts/persistentQuickUtilities.sh"
			"exec mpd"
			"exec mpDris2"
			"xdo lower -a \"Eww - bar\""
			"eww open bar"

		];

		extraConfigEarly = ''
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
