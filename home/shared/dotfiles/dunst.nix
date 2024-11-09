{
  services.dunst = {
		enable = true;
		settings = {
			global = {
				font = "DM Sans 10";
				allow_markup = true;
				format = "<b>%s</b>\\n%b";
				sort = true;
				indicate_hidden = true;
				alignment = "left";
				bounce_freq = 0;
				ellipsize = "middle";
				show_age_threshold = -1;
				word_wrap = true;
				ignore_newline = false;
				width = 320;
				height = 500;
				origin = "top-right";
				offset = "10x12";
				progress_bar = true;
				progress_bar_height = 14;
				progress_bar_frame_width = 1;
				progress_bar_min_width = 150;
				progress_bar_max_width = 300;

				frame_width = 3;
				frame_color = "#1C2325";
				transparency = 0;
				idle_threshold = 0;
				monitor = 0;
				follow = "none";
				show_indicators = false;
				sticky_history = true;
				line_height = 8;
				separator_height = 3;
		  	padding = 16;
				horizontal_padding = 12;
				text_icon_padding = 16;
				separator_color = "frame";
				startup_notification = false;
				icon_position = "left";
				min_icon_size = 32;
				max_icon_size = 48;
				corner_radius = 10;
				always_run_script = true;
				mouse_left_click = "close_current";
				mouse_middle_click = "do_action, close_current";
				mouse_right_click = "close_all";
			};
			songArtLogger = {
				script = "~/.config/nixos/home/shared/dotfiles/assets/dunst/scripts/songArtLogger.sh";
			};
			urgency_low = {
				timeout = 6;
				background = "#0b0f10";
				foreground = "#9fa0a0";
				frame_color = "#192022";
				highlight = "#7ba5dd";
			};
			urgency_normal = {
				timeout = 6;
				background = "#0b0f10";
				foreground = "#c5c8c9";
				frame_color = "#192022";
				highlight = "#7ba5dd";
			};
			urgency_critical = {
				timeout = 6;
				background = "#0b0f10";
				foreground = "#c5c8c9";
				frame_color = "#192022";
				highlight = "#ee6a70";
			};
			backlight = {
				summary = "Backlight";
				highlight = "ffb29b";
				set_stack_tag = "backlight";
			};
			volume = {
				summary = "Volume";
				set_stack_tag = "volume";
			};
			volume-muted = {
				summary = "Volume Muted";
				highlight = "#ee6a70";
			};
			volume-unmuted = {
				summary = "Volume Unmuted";
				highlight = "ee6a70";
			};
		};
	};
}
