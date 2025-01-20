{ pkgs, lib, config, ... }:

{

  # Backend Bar Assistant API
  virtualisation.oci-containers.containers.sr_server = {
    image = "barassistant/server:v4";
    autoStart = true;
    environment = {
      #APP_URL = "$API_URL";
      APP_URL = "https://sr.gideonwolfe.xyz/bar";
      LOG_CHANNEL = "stderr";
      #MEILISEARCH_KEY = "$MEILI_MASTER_KEY";
      MEILISEARCH_KEY = "gideonsbarmeilimasterkey";
      MEILISEARCH_HOST = "http://sr_search:7700";
      REDIS_HOST = "sr_redis";
    };
    volumes = [
      "/home/overseer/server/services/productivity/saltrim/barassistant/datadir:/var/www/cocktails/storage/bar-assistant"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
    environmentFiles = [ /secrets/services/saltrim/.env ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      #"traefik.http.routers.saltrim_barassistant.rule" = "Host(`sr.gideonwolfe.xyz/bar`)";
      "traefik.http.routers.saltrim_barassistant.rule" =
        "Host(`sr.gideonwolfe.xyz`) && Path(`bar`)";
      "traefik.http.routers.saltrim_barassistant.entrypoints" = "https";
      "traefik.http.routers.saltrim_barassistant.tls.certresolver" =
        "myresolver";
    };
  };

  # Frontend Vue application
  virtualisation.oci-containers.containers.sr_frontend = {
    image = "barassistant/salt-rim:v3";
    autoStart = true;
    environment = {
      #API_URL = "$API_URL";
      API_URL = "https://sr.gideonwolfe.xyz/bar";
      #MEILISEARCH_URL = "$MEILISEARCH_URL";
      MEILISEARCH_URL = "https://sr.gideonwolfe.xyz/search";
      BAR_NAME = "Gideon's Bar";
      DESCRIPTION = "it gets the job done";
      DEFAULT_LOCALE = "en-US";
    };
    extraOptions = [ "--network=traefik_proxy" ];
    environmentFiles = [ /secrets/services/saltrim/.env ];
    # labels = {
    #   "traefik.enable" = "true";
    #   "traefik.docker.network" = "traefik_proxy";
    #   "traefik.http.routers.saltrim_search.rule" = "Host(`sr.gideonwolfe.xyz`)";
    #   "traefik.http.routers.saltrim_search.entrypoints" = "https";
    #   "traefik.http.routers.saltrim_search.tls.certresolver" = "myresolver";
    # };
  };

  # NGINX to serve web application
  virtualisation.oci-containers.containers.sr_webserver = {
    image = "nginx:alpine";
    #ports = [ "3000:3000" ];
    ports = [ "4220:3000" ];
    autoStart = true;
    extraOptions = [ "--network=traefik_proxy" ];
    volumes = [
      "/home/overseer/nix/configs/hosts/athena/server/services/productivity/saltrim/nginx/nginx.conf:/etc/nginx/conf.d/default.conf"
    ];
    environmentFiles = [ /secrets/services/saltrim/.env ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.saltrim.rule" = "Host(`sr.gideonwolfe.xyz`)";
      "traefik.http.routers.saltrim.entrypoints" = "https";
      "traefik.http.routers.saltrim.tls.certresolver" = "myresolver";
    };
  };

  # Redis for caching
  virtualisation.oci-containers.containers.sr_redis = {
    image = "redis";
    autoStart = true;
    extraOptions = [ "--network=traefik_proxy" ];
    environment = { ALLOW_EMPTY_PASSWORD = "yes"; };
  };

  # Meili for searching
  virtualisation.oci-containers.containers.sr_search = {
    image = "getmeili/meilisearch:v1.7";
    autoStart = true;
    extraOptions = [ "--network=traefik_proxy" ];
    environment = {
      #MEILI_MASTER_KEY = "$MEILI_MASTER_KEY";
      MEILI_MASTER_KEY = "gideonsbarmeilimasterkey";
      MEILI_ENV = "production";
    };
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.saltrim_search.rule" =
        "Host(`sr.gideonwolfe.xyz`) && Path(`search`)";
      "traefik.http.routers.saltrim_search.entrypoints" = "https";
      "traefik.http.routers.saltrim_search.tls.certresolver" = "myresolver";
    };
    environmentFiles = [ /secrets/services/saltrim/.env ];
  };

}
