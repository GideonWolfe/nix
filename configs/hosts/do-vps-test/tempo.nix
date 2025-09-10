{ lib, modulesPath, pkgs, config, ... }: {

  services.tempo = {
    enable = true;

    settings = {
      server = {
        http_listen_port = config.local.world.hosts.monitor.tempo.port;
        grpc_listen_port = 9096; # Explicitly set to avoid conflict with Loki on 9095
      };

      distributor = {
        receivers = {
          jaeger = {
            protocols = {
              thrift_http = {
                endpoint = "0.0.0.0:14268";
              };
              grpc = {
                endpoint = "0.0.0.0:14250";
              };
            };
          };
          otlp = {
            protocols = {
              grpc = {
                endpoint = "0.0.0.0:4317";
              };
              http = {
                endpoint = "0.0.0.0:4318";
              };
            };
          };
        };
      };

      # ingester.max_block_duration = "5m" is the default, removing redundant config
      
      compactor = {
        compaction = {
          block_retention = "1h";
        };
      };

      storage = {
        trace = {
          backend = "local";
          local = {
            # path defaults to /var/lib/tempo/traces, but since NixOS sets StateDirectory = "tempo"
            # we should use the working directory relative path
            path = "./traces";
          };
          wal = {
            # path defaults to /var/lib/tempo/wal, using relative path
            path = "./wal";
          };
        };
      };
      # Simple metrics generator configuration
      metrics_generator = {
        storage = {
          path = "./generator/wal";
          remote_write = [
            {
              url = "${config.local.world.hosts.monitor.prometheus.protocol}://localhost:${toString config.local.world.hosts.monitor.prometheus.port}/api/v1/write";
            }
          ];
        };
      };
    };
  };

  # Open firewall ports for Tempo
  networking.firewall.allowedTCPPorts = [ 
    config.local.world.hosts.monitor.tempo.port  # HTTP API (3200)
    9096  # gRPC API (default, keeping for external access)
    14268 # Jaeger HTTP
    14250 # Jaeger gRPC
    4317  # OTLP gRPC
    4318  # OTLP HTTP
  ];

  # Traefik routing for Tempo
  services.traefik.dynamicConfigOptions.http.routers.tempo = {
    rule = "Host(`${config.local.world.hosts.monitor.tempo.domain}`)";
    service = "tempo";
    entryPoints = [ "http" "https" ];
    tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
    tls.certResolver = "myresolver";
  };

  services.traefik.dynamicConfigOptions.http.services.tempo = {
    loadBalancer = {
      passHostHeader = true;
      servers = [{ url = "http://${config.local.world.hosts.monitor.ip}:${toString config.local.world.hosts.monitor.tempo.port}"; }];
    };
  };
}
