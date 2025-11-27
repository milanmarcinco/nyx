{ config, pkgs, ... }:

{
  networking = {
    hostName = "nyx";

    networkmanager = {
      enable = true;
    };

    firewall = {
      checkReversePath = "loose";

      allowedTCPPorts = [
        22
      ];

      allowedTCPPortRanges = [
        { from = 9000; to = 9999; }
      ];

      allowedUDPPorts = [ ];

      interfaces.tailscale0.allowedTCPPorts = [
        22 80 443
        
        8883 # mqtts
        6060 # webdav
      ];
    };
  };
}
