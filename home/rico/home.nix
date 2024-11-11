{ config, pkgs, ... }:
	{
    imports = [ 
      ./dotfiles/bspwm.nix
      ../shared/dotfiles/theme1.nix
    ];

		nixpkgs.config.allowUnfree = true;

		home = {
			username = "rico";
			homeDirectory = "/home/rico";
			stateVersion = "24.05";
			
      sessionVariables.GTK_THEME = "Nordic-darker";
      sessionVariables.GTK_ICON_THEME = "Nordic-darker";

			packages = with pkgs; [
				htop
				neofetch
				viewnior
				xdotool
        usbutils
				hsetroot
				maim
				jq
				xclip
				xdo
				giph
				jgmenu
				feh
				playerctl
				i3lock-color
				imagemagick
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
        material-icons
        bsp-layout
        bc
        mpv
        go
        rpcs3
        ryujinx
        cargo
        lldb
        eza
        dust
        bat
        silicon
        r2modman
        gparted
        p7zip
        python312
        devenv

        lua-language-server
        rust-analyzer
        gopls
        delve
        nodePackages_latest.vscode-css-languageserver-bin
        nodePackages_latest.vscode-html-languageserver-bin
        nodePackages_latest.typescript-language-server
        pyright
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

      bash = {
        shellAliases = {
          ls = "eza";
          du = "dust";
          cat = "bat";
        };
      };
	};

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "weekly";
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
