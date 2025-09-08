{ lib, ... }: {
  # Central source of truth for external infrastructure
  options.local.world = lib.mkOption { };
  config.local.world = {
    hosts = {
      # The server that handles monitoring of my stack
      monitor = {
        # The IP of the server
        # Used for remote installation and updates
        ip = "165.227.70.3";
        # The domain that Grafana will run at
        grafana = {
          domain = "cromulus.gideonwolfe.xyz";
          protocol = "http";
          port = 3000;
          dataDir = "/var/lib/grafana";
        };
      };
    };
    email = {
      gmail = { address = "someaddress"; };
      gideonwolfe_xyz = { address = "gideon@gideonwolfe.xyz"; };
      # The email currently assigned as my infra email - just specify directly
      infra_email = { address = "gideon@gideonwolfe.xyz"; };
    };
  };
}
