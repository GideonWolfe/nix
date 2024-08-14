{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.triliumnext = {
    image = "triliumnext/notes";
    ports = [ "4215:8080" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/home/overseer/server/services/productivity/triliumnext/datadir:/home/node/trilium-data"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
