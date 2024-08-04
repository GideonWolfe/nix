{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.jellyfin = {
    image = "linuxserver/jellyfin:latest";
    ports = [ "4204:8096" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/pool/data/services/media/jellyfin/data/:/config"
      "/pool/data/media/tv/:/data/tvshows"
      "/pool/data/media/movies/:/data/movies"
    ];
    extraOptions = [ "--network=net_media" "--group-add=0" "--device=/dev/dri/renderD128:/dev/dri/renderD128" ];
  };

}
