{ config, pkgs, ... }:

{
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      global = {
        checkNewVersion = false;
        sendAnonymousUsage = false;
      };

      entryPoints = {
        http.address = ":80";
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

    dynamicConfigOptions = {
      http = {
        routers = {
          vogon-backend = {
            rule = "Host(`api.vogon.marcinco.xyz`)";
            entryPoints = [ "http" ];
            service = "vogon-backend";
          };

          vogon-emqx-dashboard = {
            rule = "Host(`emqx.vogon.marcinco.xyz`)";
            entryPoints = [ "http" ];
            service = "vogon-emqx-dashboard";
          };

          vogon-grafana = {
            rule = "Host(`grafana.vogon.marcinco.xyz`)";
            entryPoints = [ "http" ];
            service = "vogon-grafana";
          };
        };

        services = {
          vogon-backend = {
            loadBalancer.servers = [
              { url = "http://localhost:8000"; }
            ];
          };

          vogon-emqx-dashboard = {
            loadBalancer.servers = [
              { url = "http://localhost:8003"; }
            ];
          };

          vogon-grafana = {
            loadBalancer.servers = [
              { url = "http://localhost:8004"; }
            ];
          };
        };
      };

      tcp = {
        routers = {
          vogon-emqx = {
            rule = "HostSNI(`mqtt.vogon.marcinco.xyz`)";
            entryPoints = [ "mqtts" ];
            service = "vogon-emqx";
            tls.passthrough = true;
          };
        };

        services = {
          vogon-emqx = {
            loadBalancer.servers = [
              { address = "localhost:8002"; }
            ];
          };
        };
      };
    };
  };
}
