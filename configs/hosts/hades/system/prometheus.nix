{ config, lib, pkgs, inputs, ... }:

{
    services.prometheus = {
        enable = true;
        #enableAgentMode = true;
        # remoteWrite = [
        #     {
        #         url = "${config.local.world.hosts.monitor.prometheus.protocol}://${config.local.world.hosts.monitor.prometheus.domain}";
        #     }
        # ];
        exporters = {
          node = {
            enable = true;
            port = 9100;
            enabledCollectors = [
              "systemd"
              "processes" 
            ];
          };
          #systemd.enable = true;
        };
    };
}
