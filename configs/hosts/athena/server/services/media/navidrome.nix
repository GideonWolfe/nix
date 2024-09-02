{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.navidrome = {
    image = "deluan/navidrome:latest";
    ports = [ "4221:4533" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      ND_BASEURL = "https://nd.gideonwolfe.xyz";
    };
    volumes = [
      "/home/overseer/server/services/media/navidrome/data/:/data"
      "/home/overseer/test/music:/music:ro"
    ];
    extraOptions = [
      "--network=traefik_proxy"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.navidrome.rule" = "Host(`nd.gideonwolfe.xyz`)";
      "traefik.http.routers.navidrome.entrypoints" = "http,https";
      "traefik.http.routers.navidrome.tls.certresolver" = "myresolver";
    };
  };

}
