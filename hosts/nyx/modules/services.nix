{ config, pkgs, ... }:

{
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    create_ap = {
      enable = false;

      settings = {
        INTERNET_IFACE = "enp3s0";
        WIFI_IFACE = "wlp1s0";
        SSID = "nyx";
        PASSPHRASE_FILE = "/run/agenix/hotspot-psk";
      };
    };

    tailscale = {
      enable = true;
    };

    k3s = {
      enable = false;
      role = "server";
    };
  };
}
