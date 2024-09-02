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
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.trilium.rule" =
        "Host(`trilium.gideonwolfe.xyz`)";
      #"traefik.http.routers.trilium.entrypoints" = "websecure";
      "traefik.http.routers.trilium.entrypoints" = "https";
      "traefik.http.routers.trilium.tls.certresolver" = "myresolver";
    };
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
