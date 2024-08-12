{ pkgs, lib, config, ... }:

{

  services.traefik = {

    enable = true;

    # Traefik static configuration
    staticConfigOptions = {

      log.level = "DEBUG";

      api = {
        dashboard = true;
        insecure = true;
      };

      providers.docker = { network = "traefik_proxy"; };

      # Wildcard cert for all my domains
      certificatesResolvers.gideonxyzWildcard.acme = {
        email = "gideon@gideonwolfe.xyz";
        storage = "/var/lib/traefik/gideonwolfe.json";
        #caServer = "https://acme-staging-v02.api.letsencrypt.org/directory"; # remove when done testing
        # dnsChallenge = {
        #   provider = "cloudflare";
        #   resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
        # };
      };

      entryPoints = {
        web = {
          address = ":80";
          forwardedHeaders.insecure = true;
          http.redirections.entryPoint = {
            # to = "https";
            # scheme = "https";
            to = "websecure";
            scheme = "websecure";
          };
        };

        websecure = {
          address = ":443";
          forwardedHeaders.insecure = true;
        };

        experimental = {
          address = ":1111";
          forwardedHeaders.insecure = true;
        };

      };

    };

    dynamicConfigOptions = {

      http = {

        routers = {
          # Route for traefik API
          api = {
            entrypoints = [ "traefik" ];
            rule = "PathPrefix(`/api/`)";
            service = "api@internal";
          };

          jellyfin = {
            entryPoints = [ "websecure" "web" ];
            rule = "Host(`jellyfin.gideonwolfe.xyz`)";
            service = "jellyfin";
            tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
            tls.certResolver = "gideonxyzWildcard";
          };

        };
        services = {

          jellyfin = {
            loadBalancer = {
              passHostHeader = true;
              servers = [{ url = "http://localhost:4204"; }];
            };
          };

        };
      };

    };
  };

}
