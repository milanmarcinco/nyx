{ config, pkgs, lib, ... }:

let
  startScript = pkgs.writeScript "start-create-ap" ''
    #!${pkgs.bash}/bin/bash

    WIFI_PASSWORD=$(cat /run/agenix/hotspot-psk)

    exec ${pkgs.linux-wifi-hotspot}/bin/create_ap \
      wlp1s0 enp3s0 nyx "$WIFI_PASSWORD"
  '';
in {
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
      enable = true;
    };

    tailscale = {
      enable = true;
    };

    k3s = {
      enable = false;
      role = "server";
    };
  };

  systemd.services.create_ap.serviceConfig = {
      ExecStart = lib.mkForce [
        ""
        startScript
      ];
    };
}
