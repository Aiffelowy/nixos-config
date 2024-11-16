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
  boot.kernelParams = [ "amd_pstate=active" ];

  powerManagement.enable = true;
  
  system.autoUpgrade = {
    enable = true;
    flake = "/home/aiffelowy/.config/nixos/flake.nix";
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

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.0.0.3/24" ];
      privateKeyFile = "/root/.wireguard/private";

      peers = [
        {
          publicKey = "MxSYpUp0+soKnoqK0LIzKtUZ6HM9LveFe/SZR4Pl0k4=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "89.78.86.206:51820";
          persistentKeepalive = 25;
        }
      ];
    };
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
      powerManagement.enable = true;
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
      phpPackage = pkgs.php.withExtensions({all, ...}: with all; [ dom ]);
      virtualHosts.localhost = {
        documentRoot = "/home/aiffelowy/builds/no-braincells/web";
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
        mouse = {
          middleEmulation = false;
        };
      };


    asusd = {
      enable = true;
      enableUserService = true;
    };

    supergfxd.enable = true;
    tlp.enable = true;
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

  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
  systemd.services.httpd.wantedBy = lib.mkForce [ ];
  systemd.services.sshd.wantedBy = lib.mkForce [ ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    wget
    gcc
    clang
    asusctl
    php
    ntfs3g
    cifs-utils
    wireguard-tools
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

  fileSystems."/home/aiffelowy/disks/diskstation" = {
    device = "//192.168.1.145/worek";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=100ms,x-systemd.mount-timeout=5s";
    
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];

  };


  specialisation = {
    low-power.configuration = {
      boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
      boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
  
      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
      
      services.supergfxd.enable = lib.mkForce false;

      services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_BAT = lib.mkForce "powersave";
          CPU_ENERGY_PERF_POLICY_ON_BAT = lib.mkForce "power";
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 50;
        };
      };
    };
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
