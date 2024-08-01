{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/ajnart/homarr:latest";
    ports = [ "4205:8096" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/pool/data/services/admin/homarr/data/:/config"
    ];
    extraOptions = [ "--network=net_media" ];
  };

}
