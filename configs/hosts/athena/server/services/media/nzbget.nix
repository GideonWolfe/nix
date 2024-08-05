{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.nzbget = {
    image = "linuxserver/nzbget:latest";
    ports = [ "4201:6789" ];
    autoStart = true;
    environment = {
      NZBGET_USER = "test";
      NZBGET_PASS = "test";
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      #"/pool/data/services/media/nzbget/data:/config"
      "/home/overseer/server/services/media/nzbget/data/:/config"
      "/pool/data/media/downloads/:/downloads"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
