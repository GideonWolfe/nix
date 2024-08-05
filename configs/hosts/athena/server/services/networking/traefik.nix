{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:v3.1";
    ports = [ "80:80" "8080:8080" ];
    autoStart = true;
    volumes = [
      #"/home/overseer/server/services/networking/traefik/data/:/config" doesn't need local config db?
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    #extraOptions = [ "--network=net_media" ];
  };

}
