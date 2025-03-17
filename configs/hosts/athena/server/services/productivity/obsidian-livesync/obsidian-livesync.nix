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
    };
    extraOptions = [ "--network=traefik_proxy" ];
    environmentFiles = [ config.age.secrets.obsidian_livesync_env.path ];
  };

}
