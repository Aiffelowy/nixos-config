let
  homedir = "/home/aiffelowy";
	bspwmdir = "${homedir}/.config/nixos/home/shared/dotfiles/assets/bspwm";
	wallpaper = "${bspwmdir}/assets/wallpaper.png";
in
{
  xsession.windowManager.bspwm = {
		enable = true;
		
		monitors = {
			eDP = [ "1" "2" "3" "4" "5" ];
      HDMI-A-0 = [ "6" "7" ];
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
      "iwgtk" = {
        state = "floating";
      };
      ".blueman-manager-wrapped" = {
        state = "floating";
      };
		};
		
		startupPrograms = [
			"sxhkd"
			"picom"
			"${bspwmdir}/scripts/idle.sh"
			"eww --config ${homedir}/.config/nixos/home/aiffelowy/dotfiles/assets/eww daemon"
			"${bspwmdir}/scripts/ewwFullscreenFix.sh"
			"${bspwmdir}/scripts/persistentQuickUtilities.sh"
			"exec mpd"
			"exec mpDris2"
			"xdo lower -a \"Eww - bar\""
			"eww --config ${homedir}/.config/nixos/home/aiffelowy/dotfiles/assets/eww open bar"
			"eww --config ${homedir}/.config/nixos/home/aiffelowy/dotfiles/assets/eww open bar-small"

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
      xinput --map-to-output "WaveShare WS170120" "HDMI-A-0"
		'';
	};
}
