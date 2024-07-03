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
			
			packages = with pkgs; [
				htop
				neofetch
				viewnior
				xdotool
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
				networkmanagerapplet
				xprintidle
				unzip
				clang-tools
				gnumake
				libcanberra-gtk3
				krita
        iwgtk
			];
		};

		programs.home-manager.enable = true;

		programs = {
			git = {
				enable = true;
			#	extraConfig = {
			#		credential.helper = "${
			#			pkgs.git.override { withLibsecret = true; }
			#		}"/bin/git-credential-libsecret;
			#	};
			};
	};

  gtk = {
    cursorTheme = pkgs.phinger-cursors;
  };
}
