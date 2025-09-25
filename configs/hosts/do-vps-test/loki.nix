{ lib, modulesPath, pkgs, config, ... }: {

  services.loki = {
    enable = true;
    
    configuration = {
      auth_enabled = false;
      
      server = {
        http_listen_port = config.local.world.hosts.monitor.loki.port;
      };
      
      common = {
        ring = {
          instance_addr = "127.0.0.1";
          kvstore = {
            store = "inmemory";
          };
        };
        replication_factor = 1;
        path_prefix = "/var/lib/loki";
      };
      
      schema_config = {
        configs = [{
          from = "2020-05-15";
          store = "tsdb";
          object_store = "filesystem";
          schema = "v13";
          index = {
            prefix = "index_";
            period = "24h";
          };
        }];
      };
      
      storage_config = {
        filesystem = {
          directory = "/var/lib/loki/chunks";
        };
      };
    };
  };

  # Open firewall for Loki
  networking.firewall.allowedTCPPorts = [ config.local.world.hosts.monitor.loki.port ];

  # Traefik routing for Loki
  services.traefik.dynamicConfigOptions.http.routers.loki = {
    rule = "Host(`${config.local.world.hosts.monitor.loki.domain}`)";
    service = "loki";
    entryPoints = [ "http" "https" ];
    tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
    tls.certResolver = "myresolver";
  };

  services.traefik.dynamicConfigOptions.http.services.loki = {
    loadBalancer = {
      passHostHeader = true;
      servers = [{ url = "http://${config.local.world.hosts.monitor.ip}:${toString config.local.world.hosts.monitor.loki.port}"; }];
    };
  };
}
