{ config, pkgs, ... }:

{
  services.traefik.dynamicConfigOptions = {
    http = {
      routers = {
        planka = {
          rule = "Host(`planka.marcinco.xyz`)";
          entryPoints = [ "http" ];
          service = "planka";
        };
      };

      services = {
        planka = {
          loadBalancer.servers = [
            { url = "http://localhost:8010"; }
          ];
        };
      };
    };
  };
}
