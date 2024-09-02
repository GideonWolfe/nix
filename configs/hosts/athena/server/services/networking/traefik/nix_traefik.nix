{ pkgs, lib, config, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 8080 443 ];

  services.traefik = {

    enable = true;

    group = "docker";

    environmentFiles = [ /secrets/services/traefik/.env ];

    # Traefik static configuration
    staticConfigOptions = {

      log = { 
          level = "ERROR";
          #level = "DEBUG";
      };
      # Access log to be mounted in crowdsec container
      accesslog = { filepath = "/var/lib/traefik/logs/access.log"; };

      api = {
        dashboard = true;
        insecure = true;
      };

      providers.docker = {
        network = "traefik_proxy";
        exposedByDefault = false;
      };

      # Wildcard cert for all my domains
      certificatesResolvers.myresolver.acme = {
        email = "gideon@gideonwolfe.xyz";
        storage = "/var/lib/traefik/gideonwolfe.json";
        tlsChallenge = true;
        dnsChallenge = { provider = "digitalocean"; };
      };

      entryPoints = {
        http = {
          address = ":80";
          forwardedHeaders.insecure = true;
          http.redirections.entryPoint = {
            to = "https";
            scheme = "https";
          };
          http.middlewares = "crowdsec@file";
        };

        https = {
          address = ":443";
          forwardedHeaders.insecure = true;
            #BUG: TESTING
          http.middlewares = "crowdsec@file";
        };

        experimental = {
          address = ":1111";
          forwardedHeaders.insecure = true;
        };

      };

      experimental = {
        # Install the Crowdsec Bouncer plugin
        plugins = {
          #enabled = "true";
          bouncer = {
            moduleName =
              "github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin";
            version = "v1.3.3";
          };
        };
      };
    };

    dynamicConfigOptions = {

      http = {

        middlewares = {
          crowdsec = {
            plugin = {
              bouncer = {
                enabled = "true";
                logLevel = "DEBUG";
                crowdsecLapiKeyFile = "${config.age.secrets.crowdsec_api_key.path}";
                crowdsecMode = "live";
                crowdsecLapiHost = "192.168.0.158:4223";
              };
            };
          };
        };

        routers = {
          # Route for traefik API
          api = {
            entrypoints = [ "traefik" ];
            rule = "PathPrefix(`/api/`)";
            service = "api@internal";
          };

          nextcloud = {
            entryPoints = [ "https" "http" ];
            rule = "Host(`nc.gideonwolfe.xyz`)";
            service = "nextcloud";
            tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
            tls.certResolver = "myresolver";
          };

          vaultwarden = {
            entryPoints = [ "https" "http" ];
            rule = "Host(`vw.gideonwolfe.xyz`)";
            service = "vaultwarden";
            tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
            tls.certResolver = "myresolver";
          };

        };

        services = {

          nextcloud = {
            loadBalancer = {
              passHostHeader = true;
              servers = [{ url = "http://192.168.0.158:4343"; }];
            };
          };

          vaultwarden = {
            loadBalancer = {
              passHostHeader = true;
              servers = [{ url = "http://192.168.0.158:8222"; }];
            };
          };

        };
      };

    };
  };

  #HACK: since the nix service doesn't set this, Traefik tries to install plugins to /plugins-storage, which isn't in the ReadWritePaths
  systemd.services.traefik.serviceConfig = {
    WorkingDirectory = "/var/lib/traefik/";
  };

}
