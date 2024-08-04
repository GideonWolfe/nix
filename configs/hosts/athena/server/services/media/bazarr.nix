{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.bazarr = {
    image = "linuxserver/bazarr:latest";
    ports = [ "4209:6767" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      #"/pool/data/services/media/bazarr/data/:/config/"
      "/home/overseer/server/services/media/bazarr/data/:/config/"
      "/pool/data/media/tv/:/tv/"
      "/pool/data/media/movies/:/movies/"
    ];
    extraOptions = [ "--network=net_media" ];
  };

# user overseer
# pass test

}
