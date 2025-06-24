{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.freshrss = {
    image = "lscr.io/linuxserver/freshrss:latest";
    ports = [ "4222:80" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "America/New_York";
    };
    volumes =
      [ "/home/overseer/server/services/productivity/freshrss/data/:/config" ];
    extraOptions = [ "--network=traefik_proxy" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.rss.rule" = "Host(`rss.gideonwolfe.xyz`)";
      "traefik.http.routers.rss.entrypoints" = "http,https";
      "traefik.http.routers.rss.tls.certresolver" = "myresolver";
    };
  };
}
