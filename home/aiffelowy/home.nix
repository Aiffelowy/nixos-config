{ config, pkgs, ... }:
	{
    imports = [ 
    ../shared/shared-home.nix
    ./dotfiles/bspwm.nix
    ./dotfiles/rofi.nix
    ./dotfiles/dunst.nix
    ./dotfiles/kitty.nix
    ./dotfiles/picom.nix
    ./dotfiles/sxhkd.nix
    ];

		nixpkgs.config.allowUnfree = true;

		home = {
			username = "aiffelowy";
			homeDirectory = "/home/aiffelowy";
			stateVersion = "23.11";
			
      sessionVariables.GTK_THEME = "Nordic-darker";
      sessionVariables.GTK_ICON_THEME = "Nordic-darker";

			packages = with pkgs; [
				htop
				neofetch
				viewnior
				xdotool
        usbutils
				brightnessctl
				hsetroot
				maim
				jq
				xclip
				xdo
				giph
				jgmenu
				blueman
				feh
				playerctl
				i3lock-color
				imagemagick
				xorg.xev
				redshift
				pavucontrol
				phinger-cursors
				firefox
				tmux
				mpd
				mpdris2
				eww
				libnotify
				spotify
				discord
				file
				xprintidle
				unzip
				clang-tools
				gnumake
				libcanberra-gtk3
				krita
        iwgtk
        nordic
        prismlauncher
        nerdfonts
        bsp-layout
        bc
        godot_4
			];
		};

		programs.home-manager.enable = true;

		programs = {
			git = {
				enable = true;
				extraConfig = {
					credential.helper = "${
						pkgs.git.override { withLibsecret = true; }
					}/bin/git-credential-libsecret";
				};
			};
	};

  gtk = {
    cursorTheme = pkgs.phinger-cursors;
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };

    iconTheme = {
      name = "Nordic-darker";
    };
  };
}
