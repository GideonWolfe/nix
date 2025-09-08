{ pkgs, lib, config, ... }:

{
  # virtualisation.oci-containers.containers.netbox = {
  #   image = "ghcr.io/netboxcommunity/netbox:feature-3.3.0";
  #   ports = [ "4652:8080"];
  #   autoStart = true;
  #       #volumes = [ "/home/gideon/.local/share/hamclock/data/:/root/.hamclock" ];
  # };

  # netbox itself
  services.netbox = {
    enable = true;
    port = 4652;
    package = pkgs.netbox;
    listenAddress = "127.0.0.1";
    secretKeyFile = "/var/lib/netbox/secretkey.txt";
    plugins = python3Packages:
      with python3Packages; [
        netbox-routing
        netbox-floorplan-plugin
        netbox-topology-views
      ];
    extraConfig = ''
      LOGIN_REQUIRED = False
      EXEMPT_VIEW_PERMISSIONS = ['*']
      CSRF_TRUSTED_ORIGINS = [ 'http://localhost:9001' ]
    '';
    settings.PLUGINS = [
            "netbox_routing"
            "netbox_floorplan"
            "netbox_topology_views"
        ];
  };

  # HTTP server required to serve netbox
  services.nginx = {
    enable = true;
    group = "netbox";
    virtualHosts."local-netbox" = {
      listen = [{
        addr = "127.0.0.1";
        port = 9001;
      }];
      locations."/".proxyPass =
        "http://localhost:${toString config.services.netbox.port}";
      locations."/static".root = "${config.services.netbox.dataDir}";
    };
  };
}
