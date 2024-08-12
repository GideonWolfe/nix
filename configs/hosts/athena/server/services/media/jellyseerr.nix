{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.jellyseerr = {
    image = "fallenbagel/jellyseerr";
    ports = [ "4206:5055" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      #DOMAIN_JELLYSEERR2=''''${DOMAIN_JELLYSEERR}'';
    };
    volumes = [
      #"/pool/data/services/media/jellyseer/data/:/app/config"
      "/home/overseer/server/services/media/jellyseerr/data/:/app/config"
    ];
    extraOptions = [
      #"--network=net_media"
      "--network=traefik_proxy"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.jellyseerr.rule" = "Host(`jellyseerr.gideonwolfe.xyz`)";
      #"traefik.http.routers.jellyseerr.rule" = "Host(`\${DOMAIN_JELLYSEERR}`)";
      #"traefik.http.routers.jellyseerr.rule" = "Host(`$DOMAIN_JELLYSEERR`)";
      #"traefik.http.routers.jellyseerr.rule" = "Host(`{{env \"DOMAIN_JELLYSEERR\"}}`)";
      "traefik.http.routers.jellyseerr.entrypoints" = "websecure";
      "traefik.http.routers.jellyseerr.tls.certresolver" = "myresolver";
    };
    #environmentFiles = [ /home/overseer/.secrets/services/traefik/.env ];
  };

}
