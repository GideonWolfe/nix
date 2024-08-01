{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.jellyseerr = {
    image = "fallenbagel/jellyseerr";
    ports = [ "4206:5055" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/pool/data/services/media/jellyseer/data/:/app/config"
    ];
    extraOptions = [ "--network=net_media" ];
  };

}
