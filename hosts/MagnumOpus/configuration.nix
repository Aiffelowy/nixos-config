# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [ "--update-input" "nixpkgs" "-L" ];
    dates = "weekly";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };


  networking.hostName = "MagnumOpus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
        UseDefaultInterface = true;
      };
    };
  };

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable audio
  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:4:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aiffelowy = {
    isNormalUser = true;
    description = "aiffelowy";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [];
  };

  #enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #services
  services = {
    httpd = {
      enable = true;
      user = "aiffelowy";
      enablePHP = true;
      virtualHosts.localhost = {
        extraConfig = ''
        <Directory /home/aiffelowy/builds/no-braincells/web>
          DirectoryIndex index.php
          Require all granted
        </Directory>
        '';
        };
    };
    xserver = {
      enable = true;

      xkb.layout = "pl";
      xkb.variant = "";
      
      videoDrivers = [ "amdgpu" "nvidia" ];

      displayManager = {
        startx.enable = true;
      };


      desktopManager.xterm.enable = false;
    };

    displayManager.defaultSession = "none+bspwm";


    libinput = {
        enable = true;
        touchpad = {
	  tapping = true;
	  middleEmulation = true;
	  naturalScrolling = true;
        };
      };


    asusd = {
      enable = true;
      enableUserService = true;
    };

    supergfxd.enable = true;

    blueman.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
	AllowUsers = [ "aiffelowy" ];
	PermitRootLogin = "no";
      };
    };
  };

  systemd.services.httpd.serviceConfig.ProtectHome = "read-only";
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    wget
    gcc
    clang
    asusctl
    php
  ];

  programs.thunar.enable = true;
  programs.steam.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.unstable.neovim-unwrapped;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
