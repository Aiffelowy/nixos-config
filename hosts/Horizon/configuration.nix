# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.enable = true;
  
  system.autoUpgrade = {
    enable = true;
    flake = "/home/rico/.config/nixos/flake.nix";
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

    settings.trusted-users = [ "root" "@wheel" ];
  };


  networking.hostName = "Horizon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
  };

  # Enable audio
  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;


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
  users.users.rico = {
    isNormalUser = true;
    description = "rico";
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
      user = "rico";
      enablePHP = true;
      phpPackage = pkgs.php.withExtensions({all, ...}: with all; [ dom ]);
      virtualHosts.localhost = {
        documentRoot = "/home/rico/builds/no-braincells/web";
      };
      extraConfig = ''
      <Directory />
        Require all granted
        DirectoryIndex index.html
      </Directory>
      '';
    };
    xserver = {
      enable = true;

      xkb.layout = "pl";
      xkb.variant = "";
      
      videoDrivers = [ "nvidia" ];

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
        mouse = {
          middleEmulation = false;
        };
      };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "rico" ];
	      PermitRootLogin = "no";
      };
    };
  };

  systemd.services.httpd.serviceConfig.ProtectHome = "read-only";
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
  systemd.services.httpd.wantedBy = lib.mkForce [ ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    wget
    gcc
    clang
    php
    ntfs3g
    cifs-utils
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

  fileSystems."/home/rico/disks/diskstation" = {
    device = "//192.168.1.145/worek";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];

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

  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [  ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
