{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.jellyfin = {
    image = "linuxserver/jellyfin:latest";
    ports = [ "4204:8096" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/home/overseer/server/services/media/jellyfin/data/:/config"
      "/pool/data/media/tv/:/data/tvshows"
      "/pool/data/media/movies/:/data/movies"
    ];
    extraOptions = [
      "--network=traefik_proxy"
      # output of getent group render | cut -d: -f3
      "--group-add=303"
      "--device=/dev/dri/renderD128:/dev/dri/renderD128"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.jellyfin.rule" = "Host(`jellyfin.gideonwolfe.xyz`)";
      "traefik.http.routers.jellyfin.entrypoints" = "http,https";
      "traefik.http.routers.jellyfin.tls.certresolver" = "myresolver";
    };
  };
}
