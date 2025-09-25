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
        enabledCollectors = [ "systemd" "processes" ];
      };
      #systemd.enable = true;

      smartctl = {
        # Conditionally enable this if smartd is enabled
        enable = config.services.smartd.enable;
        port = 9101;
      };

      # BUG: we can only run one instance like this, maybe we can configure multiple docker containers?
      restic = {
        enable = true;
        port = 9102;
        passwordFile = config.services.restic.backups.archives.passwordFile;
        repository = config.services.restic.backups.archives.repository;
        user = config.services.restic.backups.archives.user;
      };

    };
  };
  # hack to get smartcl permissions working
  systemd.services."prometheus-smartctl-exporter".serviceConfig.DeviceAllow =
    lib.mkOverride 10 [ "block-blkext rw" "block-sd rw" "char-nvme rw" ];
}
