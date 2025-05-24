{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.mealie = {
    image = "ghcr.io/mealie-recipes/mealie:latest";
    ports = [ "4217:9000" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      BASE_URL = "https://mealie.gideonwolfe.xyz";
      TZ = "America/New_York";
      MAX_WORKERS = "1";
      WEB_CONCURRENCY = "1";

    };
    volumes = [
      "/home/overseer/server/services/productivity/mealie/datadir:/app/data"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.mealie.rule" = "Host(`mealie.gideonwolfe.xyz`)";
      "traefik.http.routers.mealie.entrypoints" = "https";
      "traefik.http.routers.mealie.tls.certresolver" = "myresolver";

    };
    extraOptions = [ "--network=traefik_proxy" ];
    #environmentFiles = [ config.age.secrets.mealie_env.path ];
    environmentFiles = [ config.sops.secrets."mealie/env".path ];
  };

}
