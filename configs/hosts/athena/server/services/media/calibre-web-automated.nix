{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.calibre-web-automated = {
    image = "crocodilestick/calibre-web-automated:latest";
    ports = [ "4232:8083" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      DOCKER_MODS = "lscr.io/linuxserver/mods:universal-calibre-v7.16.0";
    };
    volumes = [
      "/home/overseer/server/services/media/calibre-web-automated/data/config/:/config"
      "/tmp/cwa-book-ingest/:/cwa-book-ingest"
      "/pool/data/media/books/:/calibre-library"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.cw.rule" = "Host(`cw.gideonwolfe.xyz`)";
      "traefik.http.routers.cw.entrypoints" = "http,https";
      "traefik.http.routers.cw.tls.certresolver" = "myresolver";
    };
  };

  # Set up a backup for my library
  services.restic.backups.calibre_library = {
    initialize = true;
    repository = "/run/media/overseer/mnemosyne/backups/books/calibre/";
    paths = [ "/pool/data/media/books" ];
    passwordFile =
      "/run/media/overseer/mnemosyne/backuppass.txt"; # TODO:  replace this with secret
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true; # remembers last run, runs if missed
    };
    runCheck = true;
    checkOpts = [ "--read-data" ];
  };

}
