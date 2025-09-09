{ lib, modulesPath, pkgs, config, ... }: {

  services.prometheus = { 
    # Server Settings
    enable = true;
    webExternalUrl = "${config.local.world.hosts.monitor.prometheus.protocol}://${config.local.world.hosts.monitor.prometheus.domain}";
    port = config.local.world.hosts.monitor.prometheus.port or 9090;

    # Exporter Settings
    exporters.node = {
      enable = true;
      port = 9100;
      openFirewall = true;
      enabledCollectors = [
        # "arp"
        # "boottime"
        "cpu"
        "cpufreq"
        "diskstats"
        # "edac"
        # "entropy"
        "filefd"
        "filesystem"
        # "hwmon"
        # "ipvs"
        "meminfo"
        "netstat"
        # "nvme"
        "os"
        # "powersupplyclass"
        # "schedstat"
        # "sockstat"
        # "stat"
        # "thermal_zone"
        # "time"
        # "udp_queues"
        # "uname"
        # "vmstat"
        # "watchdog"
        # "interrupts"
        # "network_route"
        # "pcidevice"
        # "perf"
        # "processes"
        # "lnstat"
        # "tcpstat"
        "logind"
        "systemd"
        # "sysctl"
      ];
    };


    # Scrape configs - what Prometheus monitors
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "localhost:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
      {
        job_name = "traefik";
        # shouldn't be needed
        # metrics_path = "/metrics";
        static_configs = [
          {
            targets = [
              "localhost:8082"
            ];
          }
        ];
      }
    ]; 
  };

  services.traefik.dynamicConfigOptions.http.routers.prometheus = {
    entryPoints = [ "http" "https" ];
    rule = "Host(`${config.local.world.hosts.monitor.prometheus.domain}`)";
    service = "prometheus";
    tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
    tls.certResolver = "myresolver";
  };

  services.traefik.dynamicConfigOptions.http.services.prometheus = {
      loadBalancer = {
        passHostHeader = true;
        servers = [{ url = "http://${config.local.world.hosts.monitor.ip}:${toString config.local.world.hosts.monitor.prometheus.port}"; }];
      };
   };
}
