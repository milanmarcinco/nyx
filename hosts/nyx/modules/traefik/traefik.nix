{ config, pkgs, ... }:

{
  imports = [
    ./modules/planka.nix
    ./modules/vogon.nix
  ];
  
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      global = {
        checkNewVersion = false;
        sendAnonymousUsage = false;
      };

      entryPoints = {
        http.address = ":80";
        https.address = ":443";
        mqtts.address = ":8883";
      };

      api = {
        dashboard = false;
        insecure = false;
      };

      log = {
        level = "INFO";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
      };
    };
  };
}
