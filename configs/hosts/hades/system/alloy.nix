{ config, lib, pkgs, inputs, ... }:

{
  services.alloy = { enable = true; };

  # make the alloy config file, there is no module support yet
  environment.etc."alloy/config.alloy" = { 
    text = ''
      // Prometheus remote write endpoint
      prometheus.remote_write "default" {
        endpoint {
          //url = "http://${config.local.world.hosts.monitor.prometheus.domain}:${toString config.local.world.hosts.monitor.prometheus.port}/api/v1/write"
          // no port because traefik handles routing and TLS
          url = "http://${config.local.world.hosts.monitor.prometheus.domain}/api/v1/write"
          // Optional: add basic auth if needed
          // basic_auth {
          //   username = "user"
          //   password = "pass"
          // }
        }
      }

      // Scrape node metrics from node_exporter
      prometheus.scrape "node_exporter" {
        targets = [
          {"__address__" = "localhost:9100", "job" = "node", "instance" = "${config.networking.hostName}:9100"},
        ]
        scrape_interval = "15s"
        forward_to = [prometheus.remote_write.default.receiver]
      }

      // Optional: Scrape Alloy's own metrics
      prometheus.scrape "alloy" {
        targets = [
          {"__address__" = "localhost:12345", "job" = "alloy", "instance" = "${config.networking.hostName}"},
        ]
        scrape_interval = "15s"
        forward_to = [prometheus.remote_write.default.receiver]
      }
    '';
  };
}
