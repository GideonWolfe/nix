{ lib, modulesPath, pkgs, config, ... }: {

  networking.firewall.allowedTCPPorts =
    [ config.local.world.hosts.monitor.grafana.port ]; # 3000 for Grafana

  services.grafana = {
    enable = true;

    # Not available yet, so done manually above
    #openFirewall = true;

    dataDir = config.local.world.hosts.monitor.grafana.dataDir;

    # ONLY AVAILABLE IN UNSTABLE :()
    #declarativePlugins = with pkgs.grafanaPlugins; [
    #  grafana-piechart-panel
    #  grafana-worldmap-panel
    #  grafana-clock-panel
    #];

    settings = {

      smtp = {
        user = config.local.world.email.infra_email.address;
        # TODO consolidate so it references the password for this email directly
        password = "$__file{${config.sops.secrets."grafana/smtp/password".path}}";
        host = "$__file{${config.sops.secrets."grafana/smtp/host".path}}";
      };

      server = {
        domain = config.local.world.hosts.monitor.grafana.domain;
        http_port = config.local.world.hosts.monitor.grafana.port;
        protocol = config.local.world.hosts.monitor.grafana.protocol;
        http_addr = "0.0.0.0"; # Bind to all interfaces, not just localhost
      };

      users = {
        #password_hint = "its working hehe";
        password_hint = "$__file{${config.sops.secrets."grafana/hint".path}}";
        login_hint = "hello world";
        default_theme = "light";
      };

      security = {
        admin_user = "$__file{${config.sops.secrets."grafana/users/admin/username".path}}";
        admin_password = "$__file{${config.sops.secrets."grafana/users/admin/password".path}}";
        admin_email = "${config.local.world.email.infra_email.address}";
      };

      # Reverse Proxy settings
    };


    provision = {
      datasources = {
        settings = {
          datasources = [
            {
              name = "Prometheus";
              type = "prometheus";
              uid = "prometheus";
              url = "${config.local.world.hosts.monitor.prometheus.protocol}://localhost:${toString config.local.world.hosts.monitor.prometheus.port}";
            }
            {
              name = "Loki";
              type = "loki";
              uid = "loki";
              url = "${config.local.world.hosts.monitor.loki.protocol}://localhost:${toString config.local.world.hosts.monitor.loki.port}";
            }
            {
              name = "Tempo";
              type = "tempo";
              uid = "tempo";
              url = "${config.local.world.hosts.monitor.tempo.protocol}://localhost:${toString config.local.world.hosts.monitor.tempo.port}";
              #jsonData.streamingEnabled.search = true;
              # jsonData = {
              #   tracesToLogs = {
              #     datasourceUid = "loki";
              #     tags = ["job"];
              #   };
              #   tracesToMetrics = {
              #     datasourceUid = "prometheus";
              #     tags = [
              #       { key = "service.name"; value = "service"; }
              #       { key = "job"; }
              #     ];
              #     queries = [
              #       {
              #         name = "Sample query";
              #         query = "sum(rate(tempo_spanmetrics_latency_bucket{$$__tags}[5m]))";
              #       }
              #     ];
              #   };
              #   serviceMap = {
              #     datasourceUid = "prometheus";
              #   };
              # };
            }
          ];
        };
      };
      # dashboards = {
      #   settings = {
      #     providers = [
      #       {
      #         name = "Node Exporter";
      #         org_id = 1;
      #         folder = "";
      #         type = "file";
      #         disableDeletion = true;
      #         updateIntervalSeconds = 10; # how often Grafana will scan for changed dashboards
      #         options = {
      #           # TODO use this method: https://github.com/meenzen/nixos/blob/3ce7ed0824a282812350a20c1a3ea80fa539bb93/modules/grafana/node-exporter.nix
      #           path = "/home/gideon/nix/configs/hosts/do-vps-test/dashboards/node-exporter.json";
      #         };
      #       }
      #     ];
      #   };
      # };
    };
  };

  services.traefik.dynamicConfigOptions.http.routers.grafana = {
    entryPoints = [ "http" "https" ];
    rule = "Host(`${config.local.world.hosts.monitor.grafana.domain}`)";
    service = "grafana";
    tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
    tls.certResolver = "myresolver";
  };

  services.traefik.dynamicConfigOptions.http.services.grafana = {
      loadBalancer = {
        passHostHeader = true;
        servers = [{ url = "http://${config.local.world.hosts.monitor.ip}:3000"; }];
      };
   };
}
