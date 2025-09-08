{ lib, modulesPath, pkgs, config, ... }: {

  services.grafana = { 
    enable = true;

    # openFirewall = true; # Temporarily disabled - manually opening port below

    dataDir = config.local.world.hosts.monitor.grafana.dataDir;

    # ONLY AVAILABLE IN UNSTABLE :()
    #declarativePlugins = with pkgs.grafanaPlugins; [
    #  grafana-piechart-panel
    #  grafana-worldmap-panel
    #  grafana-clock-panel
    #];

    settings = { 

    server = {
      domain = config.local.world.hosts.monitor.grafana.domain;
      http_port = config.local.world.hosts.monitor.grafana.port;
      protocol = config.local.world.hosts.monitor.grafana.protocol;
      http_addr = "0.0.0.0"; # Bind to all interfaces, not just localhost
    };

    users = {
      password_hint = "its working hehe";
      login_hint = "hello world";
      default_theme = "light";
    };

    #security = {
    #  x_xss_protection = true;
    #};

    # Reverse Proxy settings

  }; };

    # services.traefik.dynamicConfigOptions.http.routers.grafana = {
    #   entryPoints = [ "http" "https" ];
    #   rule = "Host(`${config.local.world.hosts.monitor.grafana.domain}`)";
    #   service = "grafana";
    #   tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
    #   tls.certResolver = "myresolver";
    # };
}
