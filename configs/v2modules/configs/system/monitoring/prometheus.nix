{ config, lib, pkgs, inputs, ... }:

{
    services.prometheus = {
        enable = true;
        exporters = {
          node = {
            enable = true;
            port = 9100;
            enabledCollectors = [
              "systemd"
              "processes" 
            ];
          };
        };
    };
}
