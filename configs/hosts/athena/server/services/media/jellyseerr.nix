{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.jellyseerr = {
    image = "fallenbagel/jellyseerr";
    ports = [ "4206:5055" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes =
      [ "/home/overseer/server/services/media/jellyseerr/data/:/app/config" ];
    extraOptions = [ "--network=traefik_proxy" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.jellyseerr.rule" =
        "Host(`jellyseerr.gideonwolfe.xyz`)";
      "traefik.http.routers.jellyseerr.entrypoints" = "https";
      "traefik.http.routers.jellyseerr.tls.certresolver" = "myresolver";
    };
  };
}
