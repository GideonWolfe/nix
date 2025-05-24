{ pkgs, lib, config, ... }: {
  environment.etc."nextcloud-admin-pass".text = "PWD";
  networking.firewall = { allowedTCPPorts = [ 4343 ]; };
  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen =
    [{
      addr = "0.0.0.0";
      port = 4343; # NOT an exposed port
    }];
  services.nextcloud = {

    enable = true;
    # Increment to upgrade
    #package = pkgs.nextcloud30;
    package = pkgs.nextcloud31;

    # Must match hostname in traefik config
    hostName = "nc.gideonwolfe.xyz";
    config = {
      #adminpassFile = "/home/overseer/.secrets/services/nextcloud/nc_mysql_admin_pass"; 
      dbtype = "sqlite";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };

    # Generated links include https, also enables HSTS header and maxage
    https = true;

    # Use Redis for caching
    configureRedis = true;

    # Add some recommended headers
    nginx.recommendedHttpHeaders = true;

    # Enable installation of app store apps (should eventually add good apps decleratively)
    appstoreEnable = true;

    # Settings that will get appended to config.php
    settings = {
      # this is the output of running docker network inpect traefik_proxy and taking the value for subnet
      trusted_proxies = [ "172.20.0.0/16" ];
      # This fixes NC failing to redirect properly after login/logout/etc
      overwriteprotocol = "https";

      default_phone_region = "US";

      # 3AM EST 
      maintenance_window_start = "6";
    };

    # settings we want to apply to php.ini
    phpOptions = {
      # Will throw warning with default low value
      "opcache.interned_strings_buffer" = "23";

      # Add tools for Memories
      "memories.exiftool" = "${lib.getExe pkgs.exiftool}";
      "memories.vod.ffmpeg" = "${lib.getExe pkgs.ffmpeg-headless}";
      "memories.vod.ffprobe" = "${pkgs.ffmpeg-headless}/bin/ffprobe";
    };

    # Default installed apps
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        contacts calendar tasks cookbook phonetrack maps bookmarks mail memories
        impersonate spreed previewgenerator;

      #BUG: not showing up in nextcloud
      # news = pkgs.fetchNextcloudApp {
      #   sha256 = "00dwz0j7mwlp2mxlxbvpzjvz2a29x7fiysxg0rdwvyns37vgb2ly";
      #   url =
      #     "https://github.com/gino0631/nextcloud-metadata/releases/download/v0.20.0/metadata.tar.gz";
      #   license = "gpl3";
      # };
      #
      # BUG: throws error in nextcloud
      # drawio = pkgs.fetchNextcloudApp {
      #   sha256 = "1xg3kmv1hhkv7aw0l7x5cn7lkm5r5klxkfrd1gikhxx8kfgg48hr";
      #   url = "https://github.com/jgraph/drawio-nextcloud/releases/download/v3.0.2/drawio-v3.0.2.tar.gz";
      #   license = "gpl3";
      # };
      #
    };
    extraAppsEnable = true;
  };

  # Make sure memories Cron job can use programs
  systemd.services.nextcloud-cron = { path = [ pkgs.perl ]; };

}
