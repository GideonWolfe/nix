{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.radarr = {
    image = "linuxserver/radarr:latest";
    ports = [ "4207:7878" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/pool/data/services/media/radarr/data/:/config/"
      "/pool/data/media/movies/:/movies/"
      "/pool/data/media/downloads/:/downloads"
    ];
    extraOptions = [ "--network=net_media" ];
  };


}
