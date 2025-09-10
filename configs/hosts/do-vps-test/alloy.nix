{ config, lib, pkgs, inputs, ... }:

{
  services.alloy = { enable = true; };

  # make the alloy config file, there is no module support yet
  environment.etc."alloy/config.alloy" = { 
    text = ''
      // Loki remote write endpoint
      loki.write "default" {
        endpoint {
          url = "http://localhost:${toString config.local.world.hosts.monitor.loki.port}/loki/api/v1/push"
        }
      }

      // Collect systemd journal logs
      loki.source.journal "journal" {
        max_age = "12h"
        labels = {
          job = "systemd-journal",
          host = "${config.networking.hostName}",
        }
        forward_to = [loki.write.default.receiver]
      }
    '';
  };
}
