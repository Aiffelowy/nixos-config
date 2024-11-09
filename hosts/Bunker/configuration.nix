# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./docker/pihole.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "consoleblank=60" ];

  networking.hostName = "Bunker"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = { 
    networkmanager.enable = false;
    enableIPv6 = false;
    
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 25565 53 8080 ];
      allowedUDPPorts = [ 25565 53 51820 ];
    };

    nat = {
      enable = true;
      externalInterface = "enp57s0u1";
      internalInterfaces = [ "wg0" ];
    };

    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.0.0.1/24" ];
        listenPort = 51820;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp57s0u1 -j MASQUERADE
        '';

        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o enp57s0u1 -j MASQUERADE
        '';
        
	privateKeyFile = "/root/.wireguard/private";
        peers = [
          { # MagnumOpus
            publicKey = "sri0ne2VxC5nqJFJxJ7fdNNH09l1ntOt5oNkXNqbf0Q=";
	    allowedIPs = [ "10.0.0.3/32" ];
          }
          { # Phone
            publicKey = "CTAB8T+9prGjjldlbg5OfWpkh6LFC2Xhc5C5Z8nB028=";
	    allowedIPs = [ "10.0.0.4/32" ];
          }
        ];
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
  users.users.six-oh = {
    isNormalUser = true;
    description = "six-oh";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
	      AllowUsers = ["six-oh"];
	      PermitRootLogin = "no";
      };
    };

    logind = {
      lidSwitch = "lock";
      lidSwitchDocked = "lock";
      lidSwitchExternalPower = "lock";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker = {
    autoPrune.enable = true;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };

    daemon.settings = {
      userland-proxy = false;
      metrics-addr = "0.0.0.0:9323";
      ipv6 = false;
    };
  };

  virtualisation.oci-containers.backend = "docker";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    wireguard-tools
  ];

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
