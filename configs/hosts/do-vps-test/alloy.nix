{ config, lib, pkgs, inputs, ... }:

{
  services.alloy = { enable = true; };

  # Override the systemd service to add traefik group access
  #systemd.services.alloy.serviceConfig.SupplementaryGroups = [ "systemd-journal" "traefik" ];

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
        format_as_json = true
      }

      // Collect Traefik logs from systemd journal
      // Example on filtering
      loki.source.journal "traefik" {
        max_age = "12h"
        labels = {
          job = "traefik-logs",
          host = "${config.networking.hostName}",
        }
        matches = "_SYSTEMD_UNIT=traefik.service"
        forward_to = [loki.write.default.receiver]
        format_as_json = true
      }

      // Collect SSH logs from systemd journal
      loki.source.journal "sshd" {
        max_age = "12h"
        labels = {
          job = "ssh-logs",
          host = "${config.networking.hostName}",
        }
        matches = "_SYSTEMD_UNIT=sshd.service"
        forward_to = [loki.write.default.receiver]
        format_as_json = true
      }


      // TESTING - Collect SSH logs for processing
      loki.source.journal "sshd_failed" {
        max_age = "12h"
        labels = {
          job  = "ssh-failed-auth",
          host = "${config.networking.hostName}",
        }

        // Only pull logs from sshd
        matches = "_SYSTEMD_UNIT=sshd.service"

        forward_to = [loki.process.sshd_failed.receiver]
      }

      // Process SSH failed login logs
      loki.process "sshd_failed" {
        stage.match {
          selector = "{job=\"ssh-failed-auth\"}"
          selector = "{line =~ `Invalid user`}"
          
          stage.regex {
            //expression = `/^Invalid user (?P<user>\S+) from (?P<ip>[0-9.]+) port (?P<port>[0-9]+)$/gm`
            expression = `^Invalid user (?P<user>\S+) from (?P<ip>[0-9.]+) port (?P<port>[0-9]+)`
          }
          
          stage.labels {
            values = {
              user = "user",
              ip = "ip",
              port = "port",
            }
          }
        }

        forward_to = [loki.write.default.receiver]
      }

      // Collect Traefik application logs
      // NOT WORKING BECAUSE FILE PERMISSIONS ON LOG
      loki.source.file "traefik_app_logs" {
        targets = [
          {
            __path__ = "/var/lib/traefik/traefik.log",
            job = "traefik-app",
            host = "${config.networking.hostName}",
          },
        ]
        forward_to = [loki.write.default.receiver]
      }

      // Collect Traefik access logs
      // NOT WORKING BECAUSE FILE PERMISSIONS ON LOG
      loki.source.file "traefik_access_logs" {
        targets = [
          {
            __path__ = "/var/lib/traefik/access.log",
            job = "traefik-access",
            host = "${config.networking.hostName}",
          },
        ]
        forward_to = [loki.write.default.receiver]
      }
    '';
  };
}
