{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.prowlarr = {
    image = "linuxserver/prowlarr:latest";
    ports = [ "4203:9696" ];
    autoStart = true;
    volumes = [
      "/pool/data/services/media/prowlarr/data/:/config/"
    ];
    extraOptions = [ "--network=net_media" ];
  };

}