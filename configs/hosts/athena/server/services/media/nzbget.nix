{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.nzbget = {
    image = "linuxserver/nzbget:latest";
    ports = [ "4201:6789" ];
    autoStart = true;
    environment = {
      NZBGET_USER = "test";
      NZBGET_PASS = "test";
    };
    volumes = [
      "/home/overseer/server/services/media/nzbget/datadir:/config"
    ];
    extraOptions = [ "--network=net_media" ];
  };

}
