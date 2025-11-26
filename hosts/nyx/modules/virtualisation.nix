{ config, pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    
    docker = {
      enable = true;
    };

    podman = {
      enable = true;
      dockerCompat = false;
      dockerSocket.enable = false;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
