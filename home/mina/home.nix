{config, pkgs, ...}: {

	nixpkgs.config.allowUnfree = true;

	home = {
		username = "mina";
		homeDirectory = "/home/mina";
		stateVersion = "24.11";
		

		packages = with pkgs; [
			htop
      rnote
      firefox-bin
      spotify
      nautilus
      pywal
      bibata-cursors
      papirus-icon-theme
      grim
      slurp
      grimblast
      cliphist
      wlogout
      nwg-look
      kdePackages.qt6ct
      rofi-wayland
      waybar
      hyprpaper
      waypaper
      hypridle
      hyprlock
      hyprpicker
      libnotify
      uwsm
      sddm
		];
	};
	
	programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      remember_window_size = false;
      enable_audio_bell = false;
      hide_window_decorations = true;
      background_opacity = 0.7;
      dynamic_background_opacity = true;
      confirm_os_window_close = 0;
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        width = 300;
        height = 300;
        origin = "top-center";
        offset = "30x30";
        scale = 0;
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 10;
        icon_corner_radius = 0;
        indicate_hidden = true;
        transparency = 30;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 1;
        frame_color = "#ffffff";
        gap_size = 0;
        separator_color = "frame";
        sort = true;
        font = "Fira Sans Semibold 9";
        line_height = 1;
        allow_markup = true;
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        enable_recursive_icon_lookup = true;
        icon_theme = "Papirus-Dark,Adwaita";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 128;
        sticky_history = true;
        history_length = 20;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 10;
        always_run_script = true;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        background = "#000000CC";
        foreground = "#888888";
        timeout = 6;
      };
      urgency_normal = {
        background = "#000000CC";
        foreground = "#ffffff";
        timeout = 6;
      };
      urgency_critical = {
        background = "#900000CC";
        foreground = "#ffffff";
        frame_color = "#ffffff";
        timeout = 6;
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";


      bind = [
        "CTRL_ALT, t, exec, kitty"
      ] ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 5)
      );
    };
  };
}
