{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/ajnart/homarr:latest";
    ports = [ "4205:7575" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      #"/pool/data/services/admin/homarr/data/:/app/data/configs"
      "/home/overseer/server/services/admin/homarr/data/:/app/data/configs"
      "/var/run/docker.sock:/var/run/docker.sock"

    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };


}
