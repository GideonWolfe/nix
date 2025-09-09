# World configuration data - can be imported as values
{
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
      prometheus = {
        #dataDir = "/var/lib/prometheus";
        protocol = "http";
        domain = "prom.gideonwolfe.xyz";
        port = 9090;
      };
      loki = {
        protocol = "http";
        domain = "loki.gideonwolfe.xyz";
        port = 3100;
      };
    };
  };
  email = {
    gmail = { address = "someaddress"; };
    gideonwolfe_xyz = { address = "gideon@gideonwolfe.xyz"; };
    # The email currently assigned as my infra email - just specify directly
    infra_email = { address = "gideon@gideonwolfe.xyz"; };
  };
}
