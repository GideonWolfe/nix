{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.mealie = {
    image = "ghcr.io/mealie-recipes/mealie:latest";
    ports = [ "4217:9000" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      #BASE_URL = "https://mealie.yourdomain.com";
      TZ = "America/New_York";
      MAX_WORKERS = 1;
      WEB_CONCURRENCY = 1;

    };
    volumes = [
      "/home/overseer/server/services/productivity/mealie/datadir:/app/data"
    ];
    # labels = {
    #   "traefik.enable" = "true";
    #   "traefik.docker.network" = "traefik_proxy";
    #   "traefik.http.routers.trilium.rule" =
    #     "Host(`trilium.gideonwolfe.xyz`)";
    #   #"traefik.http.routers.trilium.entrypoints" = "websecure";
    #   "traefik.http.routers.trilium.entrypoints" = "https";
    #   "traefik.http.routers.trilium.tls.certresolver" = "myresolver";
    # };
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
