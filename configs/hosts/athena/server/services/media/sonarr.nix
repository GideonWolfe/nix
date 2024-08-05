{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.sonarr = {
    image = "linuxserver/sonarr:latest";
    ports = [ "4202:8989" ];
    autoStart = true;
    #user = "nobody:nogroup";
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      #"/pool/data/services/media/sonarr/data/:/config/"
      "/home/overseer/server/services/media/sonarr/data/:/config/"
      "/pool/data/media/tv/:/tv/"
      "/pool/data/media/downloads/:/downloads"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };

# user overseer
# pass test

}
