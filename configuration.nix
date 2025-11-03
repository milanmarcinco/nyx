# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Bratislava";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking = {
    hostName = "nyx";

    # wireless = {
    #   enable = false;
    # };
    
    networkmanager = {
      enable = true;
    };
    
    firewall = {
      checkReversePath = "loose";

      allowedTCPPorts = [
        22 80 443
      ];

      allowedTCPPortRanges = [
        # { from = 3000; to = 4000 }
      ];

      allowedUDPPorts = [

      ];

      interfaces = {
        "tailscale0" = {
          allowedTCPPorts = [];
        };
      };
    };
  };

  services = {
    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    openssh = {
      enable = true;
    };

    create_ap = {
      enable = true;
      settings = {
        INTERNET_IFACE = "enp3s0";
        WIFI_IFACE = "wlp1s0";
        SSID = "nyx";
        PASSPHRASE = builtins.readFile /etc/nixos/secrets/hotspot-psk;
      };
    };

    tailscale = {
      enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.milan = {
    isNormalUser = true;
    description = "Milan Marcinco";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];

    openssh = {
      authorizedKeys = {
        keyFiles = [
          /etc/nixos/ssh/authorized_keys
        ];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano wget curl tmux htop fastfetch
    git tailscale
  ];

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];

  nix.gc.automatic = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
