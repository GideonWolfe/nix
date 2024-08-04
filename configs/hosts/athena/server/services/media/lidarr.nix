{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.lidarr = {
    image = "linuxserver/lidarr:latest";
    ports = [ "4208:8686" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      #"/pool/data/services/media/lidarr/data/:/config/"
      "/home/overseer/server/services/media/lidarr/data/:/config/"
      "/pool/data/media/music:/music"
      "/pool/data/media/downloads/:/downloads"
    ];
    extraOptions = [ "--network=net_media" ];
  };


}
