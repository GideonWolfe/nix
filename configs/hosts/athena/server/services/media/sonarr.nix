{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.sonarr = {
    image = "linuxserver/sonarr:latest";
    ports = [ "4202:8989" ];
    autoStart = true;
    # environment = {
    #   NZBGET_USER = "test";
    #   NZBGET_PASS = "test";
    # };
    volumes = [
      "/pool/data/services/media/radarr/data/:/config/"
      "/pool/data/media/tv/:/tv/"
      "/pool/data/media/downloads/:/downloads/"
    ];
    extraOptions = [ "--network=net_media" ];
  };

# user overseer
# pass test

}
