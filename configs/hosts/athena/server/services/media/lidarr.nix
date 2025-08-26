{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.lidarr = {
    image = "linuxserver/lidarr:2.11.2.4629-ls43";
    ports = [ "4208:8686" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      #"/pool/data/services/media/lidarr/data/:/config/"
      "/home/overseer/server/services/media/lidarr/data/:/config/"
      #"/pool/data/media/music:/music"
      "/home/overseer/test/music:/music"
      "/pool/data/media/downloads/:/downloads"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };


}
