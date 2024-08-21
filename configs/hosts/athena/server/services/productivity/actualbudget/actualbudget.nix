{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.actualbudget = {
    image = "actualbudget/actual-server:latest";
    ports = [ "4216:5006" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/home/overseer/server/services/productivity/actualbudget/data/:/data"
    ];
    extraOptions = [
      "--network=traefik_proxy"
    ];
    # labels = {
    #   "traefik.enable" = "true";
    #   "traefik.docker.network" = "traefik_proxy";
    #   "traefik.http.routers.jellyfin.rule" = "Host(`jellyfin.gideonwolfe.xyz`)";
    #   "traefik.http.routers.jellyfin.entrypoints" = "http,https";
    #   "traefik.http.routers.jellyfin.tls.certresolver" = "myresolver";
    # };
  };

}
