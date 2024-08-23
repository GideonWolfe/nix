{ pkgs, lib, config, ... }:

{

  # Backend Bar Assistant API
  virtualisation.oci-containers.containers.sr_server = {
    image = "barassistant/server:v3";
    autoStart = true;
    environment = {
      APP_URL = "$API_URL";
      LOG_CHANNEL = "stderr";
      MEILISEARCH_KEY = "$MEILI_MASTER_KEY";
      MEILISEARCH_HOST = "http://sr_search:7700";
      REDIS_HOST = "sr_redis";
    };
    volumes = [
      "/home/overseer/server/services/productivity/saltrim/barassistant/datadir:/var/www/cocktails/storage/bar-assistant"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
    environmentFiles = [ /secrets/services/saltrim/.env ];
  };

  # Frontend Vue application
  virtualisation.oci-containers.containers.sr_frontend = {
    image = "barassistant/salt-rim:v2";
    autoStart = true;
    environment = {
      API_URL = "$API_URL";
      MEILISEARCH_URL = "$MEILISEARCH_URL";
      BAR_NAME = "$BAR_NAME";
      DESCRIPTION = "$BAR_DESCRIPTION";
      DEFAULT_LOCALE = "en-US";
    };
    extraOptions = [ "--network=traefik_proxy" ];
    environmentFiles = [ /secrets/services/saltrim/.env ];
  };

  # NGINX to serve web application
  virtualisation.oci-containers.containers.sr_webserver = {
    image = "nginx:alpine";
    ports = [ "3000:3000" ];
    autoStart = true;
    extraOptions = [ "--network=traefik_proxy" ];
    volumes = [
      "/home/overseer/nix/configs/hosts/athena/server/services/productivity/saltrim/nginx/nginx.conf:/etc/nginx/conf.d/default.conf"
    ];
    environmentFiles = [ /secrets/services/saltrim/.env ];
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
      MEILI_MASTER_KEY = "$MEILI_MASTER_KEY";
      MEILI_ENV = "production";
    };
    environmentFiles = [ /secrets/services/saltrim/.env ];
  };

}
