{ lib, ... }: {
  # Central source of truth for external infrastructure
  options.local.world = lib.mkOption { };
  config.local.world = {
    hosts = {
      # The server that handles monitoring of my stack
      monitor = {
        # The IP of the server
        # Used for remote installation and updates
        ip = "xx.xxx.xx.xx";
        # The domain that Grafana will run at
        grafana = {
          domain = "grafana.somedomain.tld";
          port = 8080;
        };
      };
    };
  };
}
