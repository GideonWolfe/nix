{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/ajnart/homarr:0.15.10";
    ports = [ "4205:7575" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      BASE_URL = "https://homarr.gideonwolfe.xyz";
    };
    volumes = [
      #"/pool/data/services/admin/homarr/data/:/app/data/configs"
      "/home/overseer/server/services/admin/homarr/configs/:/app/data/configs"
      "/home/overseer/server/services/admin/homarr/data/:/data"
      "/var/run/docker.sock:/var/run/docker.sock"

    ];
    extraOptions = [ "--network=traefik_proxy" ];

    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.homarr.rule" = ''Host(`homarr.gideonwolfe.xyz`)'';
      "traefik.http.routers.homarr.entrypoints" = "http,https";
      "traefik.http.routers.homarr.tls.certresolver" = ''myresolver'';
    };

  };

}
