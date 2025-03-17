{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.obsidian-livesync = {
    image = "couchdb";
    ports = [ "4687:5984" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/home/overseer/server/services/productivity/obsidian-livesync/datadir/data:/opt/couchdb/data"
      "/home/overseer/server/services/productivity/obsidian-livesync/datadir/local.d:/opt/couchdb/etc/local.d"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.ols.rule" = "Host(`ols.gideonwolfe.xyz`)";
      "traefik.http.routers.ols.entrypoints" = "https";
      "traefik.http.routers.ols.tls.certresolver" = "myresolver";
      "traefik.http.services.ols.loadbalancer.server.port" = "5984";
      # https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/setup_own_server.md#traefik
      # The part needed for CORS to work on Traefik 2.x starts here
      "traefik.http.routers.ols.middlewares" = "obsidiancors";
      "traefik.http.middlewares.obsidiancors.headers.accesscontrolallowmethods" =
        "GET,PUT,POST,HEAD,DELETE";
      "traefik.http.middlewares.obsidiancors.headers.accesscontrolallowheaders" =
        "accept,authorization,content-type,origin,referer";
      "traefik.http.middlewares.obsidiancors.headers.accesscontrolalloworiginlist" =
        "app://obsidian.md,capacitor://localhost,http://localhost";
      "traefik.http.middlewares.obsidiancors.headers.accesscontrolmaxage" =
        "3600";
      "traefik.http.middlewares.obsidiancors.headers.addvaryheader" = "true";
      "traefik.http.middlewares.obsidiancors.headers.accessControlAllowCredentials" =
        "true";
    };
    extraOptions = [ "--network=traefik_proxy" ];
    environmentFiles = [ config.age.secrets.obsidian_livesync_env.path ];
  };

}
