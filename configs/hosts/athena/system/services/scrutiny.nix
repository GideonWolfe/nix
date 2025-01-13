{ config, lib, pkgs, ... }:

{
  # Enable Scrutiny
  services.scrutiny = {
    enable = true;
    collector = { enable = true; };
    #influxdb = { enable = true; };
    settings = { web = { listen = { port = 5232; }; }; };
  };
}
