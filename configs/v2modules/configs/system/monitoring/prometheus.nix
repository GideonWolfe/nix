{ config, lib, pkgs, inputs, ... }:

{
    services.prometheus = {
        enable = config.custom.features.monitoring.enable;
        exporters = {
          node = {
            enable = config.custom.features.monitoring.enable;
            port = 9100;
            enabledCollectors = [
              "systemd"
              "processes" 
            ];
          };
        };
    };
}
