{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.hoarder = {
    image = "ghcr.io/hoarder-app/hoarder:release";
    ports = [ "4230:3000" ];
    autoStart = true;
    environment = {
      HOARDER_VERSION = "release";
      NEXTAUTH_URL = "http://localhost:4224";
      NEXTAUTH_SECRET = "nextauthsecret";
      DATA_DIR = "/data";
      MEILI_ADDR = "http://hoarder-meili:7700";
      BROWSER_WEB_URL = "http://hoarder-chrome:9222";
      MEILI_MASTER_KEY = "somerandomstring";
    };
    volumes = [
      "/home/overseer/server/services/productivity/hoarder/hoarder/data/:/data"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.hoarder.rule" = "Host(`hoarder.gideonwolfe.xyz`)";
      "traefik.http.routers.hoarder.entrypoints" = "http,https";
      "traefik.http.routers.hoarder.tls.certresolver" = "myresolver";
    };
  };

  virtualisation.oci-containers.containers.hoarder-chrome = {
    image = "gcr.io/zenika-hub/alpine-chrome:123";
    ports = [ "9222:9222" ];
    extraOptions = [ "--network=traefik_proxy" ];
    cmd = [
      "--no-sandbox"
      "--disable-gpu"
      "--disable-dev-shm-usage"
      "--remote-debugging-address=0.0.0.0"
      "--remote-debugging-port=9222"
      "--hide-scrollbars"
    ];
  };
  virtualisation.oci-containers.containers.hoarder-meili = {
    image = "getmeili/meilisearch:v1.6";
    extraOptions = [ "--network=traefik_proxy" ];
    environment = {
      MEILI_NO_ANALYTICS = "true";
      MEILI_MASTER_KEY = "somerandomstring";
    };
    volumes = [
      "/home/overseer/server/services/productivity/hoarder/meili/data/:/meili_data"
    ];
  };
}
