{ config, lib, ... }:

{
  options.custom.world = {
    hosts = {
      monitor = {
        ip = lib.mkOption {
          type = lib.types.str;
          default = "165.227.70.3";
          description = "The IP of the monitoring server used for remote installation and updates";
        };

        grafana = {
          domain = lib.mkOption {
            type = lib.types.str;
            default = "cromulus.gideonwolfe.xyz";
            description = "The domain that Grafana will run at";
          };

          protocol = lib.mkOption {
            type = lib.types.enum [ "http" "https" ];
            default = "http";
            description = "Protocol for Grafana service";
          };

          port = lib.mkOption {
            type = lib.types.port;
            default = 3000;
            description = "Port for Grafana service";
          };

          dataDir = lib.mkOption {
            type = lib.types.str;
            default = "/var/lib/grafana";
            description = "Data directory for Grafana";
          };
        };

        prometheus = {
          protocol = lib.mkOption {
            type = lib.types.enum [ "http" "https" ];
            default = "http";
            description = "Protocol for Prometheus service";
          };

          domain = lib.mkOption {
            type = lib.types.str;
            default = "prom.gideonwolfe.xyz";
            description = "Domain for Prometheus service";
          };

          port = lib.mkOption {
            type = lib.types.port;
            default = 9090;
            description = "Port for Prometheus service";
          };
        };

        loki = {
          protocol = lib.mkOption {
            type = lib.types.enum [ "http" "https" ];
            default = "http";
            description = "Protocol for Loki service";
          };

          domain = lib.mkOption {
            type = lib.types.str;
            default = "loki.gideonwolfe.xyz";
            description = "Domain for Loki service";
          };

          port = lib.mkOption {
            type = lib.types.port;
            default = 3100;
            description = "Port for Loki service";
          };
        };

        tempo = {
          protocol = lib.mkOption {
            type = lib.types.enum [ "http" "https" ];
            default = "http";
            description = "Protocol for Tempo service";
          };

          domain = lib.mkOption {
            type = lib.types.str;
            default = "tempo.gideonwolfe.xyz";
            description = "Domain for Tempo service";
          };

          port = lib.mkOption {
            type = lib.types.port;
            default = 3200;
            description = "Port for Tempo service";
          };
        };
      };

      # WireGuard VPN server configuration
      wireguard = {
        serverIp = lib.mkOption {
          type = lib.types.str;
          default = "66.108.176.86";
          description = "WireGuard server public IP address";
        };

        publicKey = lib.mkOption {
          type = lib.types.str;
          default = "Rv8R1GmrerXlqqc7nTvzLTimStbSjoBj/SYGzvIdzQs=";
          description = "WireGuard server public key";
        };

        vpnServerIp = lib.mkOption {
          type = lib.types.str;
          default = "10.100.0.1";
          description = "WireGuard server IP address in the VPN network";
        };

        network = lib.mkOption {
          type = lib.types.str;
          default = "10.100.0.0/24";
          description = "WireGuard VPN network CIDR";
        };

        port = lib.mkOption {
          type = lib.types.port;
          default = 123;
          description = "WireGuard listen port";
        };

        clients = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options = {
              publicKey = lib.mkOption {
                type = lib.types.str;
                default = "PENDING_KEY_GENERATION";
                description = "Client public key (update after deployment)";
              };
              vpnIp = lib.mkOption {
                type = lib.types.str;
                description = "Client VPN IP address (without CIDR)";
              };
            };
          });
          default = {
            # Example client configurations
            sisyphus = {
              publicKey = "PENDING_KEY_GENERATION";
              vpnIp = "10.100.0.4";
            };
            hades = {
              publicKey = "PENDING_KEY_GENERATION";
              vpnIp = "10.100.0.8";
            };
            poseidon = {
              publicKey = "PENDING_KEY_GENERATION";
              vpnIp = "10.100.0.6";
            };
            alpha = {
              publicKey = "PENDING_KEY_GENERATION";
              vpnIp = "10.100.0.5";
            };
            beta = {
              publicKey = "Vf/9UVNxgtkOwpUFRf0Qpm4UCa2WXPRQw0deBaXEdDI="; # athena doesn't reference it yet
              vpnIp = "10.100.0.9";
            };
          };
          description = "WireGuard client configurations";
        };
      };

      homeserver = {
        ip = lib.mkOption {
          type = lib.types.str;
          default = "66.108.176.86";
          description = "The IP of my homeserver";
        };
      };

      # K3s cluster configuration
      cluster = {
        ip = lib.mkOption {
          type = lib.types.str;
          default = "192.168.0.50";
          description = "The virtual IP (VIP) of the k3s cluster";
        };

        alpha = {
          ip = lib.mkOption {
            type = lib.types.str;
            default = "192.168.0.163";
            description = "The IP address of the alpha node";
          };
        };

        beta = {
          ip = lib.mkOption {
            type = lib.types.str;
            default = "192.168.0.116";
            description = "The IP address of the beta node";
          };
        };
      };

    };

    locations = {
      nyc = {
        lat = lib.mkOption {
          type = lib.types.float;
          default = 40.7128;
          description = "NYC Latitude";
        };
        long = lib.mkOption {
          type = lib.types.float;
          default = -74.0060;
          description = "NYC Longitude";
        };
      };
    };

    email = {
      gmail = {
        address = lib.mkOption {
          type = lib.types.str;
          default = "someaddress";
          description = "Gmail address";
        };
      };

      gideonwolfe_xyz = {
        address = lib.mkOption {
          type = lib.types.str;
          default = "gideon@gideonwolfe.xyz";
          description = "Primary gideonwolfe.xyz email address";
        };
      };

      infra_email = {
        address = lib.mkOption {
          type = lib.types.str;
          default = "gideon@gideonwolfe.xyz";
          description = "The email currently assigned as infrastructure email";
        };
      };
    };
  };

  # No config section needed - this is purely for defining options/configuration schema
}
