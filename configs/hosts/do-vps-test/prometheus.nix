{ lib, modulesPath, pkgs, config, ... }: {

  services.prometheus = { 
    enable = true;
    webExternalUrl = "${config.local.world.hosts.monitor.prometheus.protocol}://${config.local.world.hosts.monitor.prometheus.domain}";
  };
}
