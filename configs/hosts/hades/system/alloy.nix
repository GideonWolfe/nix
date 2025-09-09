{ config, lib, pkgs, inputs, ... }:

{
  services.alloy = { enable = true; };

  # make the alloy config file, there is no module support yet
  environment.etc."alloy/config.alloy" = { 
    text = ''
      // Prometheus remote write endpoint
      prometheus.remote_write "default" {
        endpoint {
          // no port because traefik handles routing and TLS
          url = "http://${config.local.world.hosts.monitor.prometheus.domain}/api/v1/write"
        }
      }

      // Scrape node metrics from node_exporter
      prometheus.scrape "node_exporter" {
        targets = [
          {"__address__" = "localhost:${toString config.services.prometheus.exporters.node.port}", "job" = "node", "instance" = "${config.networking.hostName}:${toString config.services.prometheus.exporters.node.port}"},
        ]
        scrape_interval = "15s"
        forward_to = [prometheus.remote_write.default.receiver]
      }

      // Optional: Scrape Alloy's own metrics
      prometheus.scrape "alloy" {
        targets = [
          {"__address__" = "localhost:12345", "job" = "alloy", "instance" = "${config.networking.hostName}:12345"},
        ]
        scrape_interval = "15s"
        forward_to = [prometheus.remote_write.default.receiver]
      }
    '';
  };
}
