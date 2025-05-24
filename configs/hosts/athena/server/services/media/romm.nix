{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.romm = {
    image = "rommapp/romm:latest";
    ports = [ "4240:8080" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
    };
    volumes = [
      "/pool/data/media/games/roms/romm/romm_resources:/romm/resources"
      "/pool/data/media/games/roms/romm/romm_redis_data:/redis-data"
      "/pool/data/media/games/roms/romm/library:/romm/library"
      "/pool/data/media/games/roms/romm/assets:/romm/assets"
      "/pool/data/media/games/roms/romm/config:/romm/config"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
    dependsOn = [ "romm-db" ];
    labels = {
      "traefik.enable" = "true";
      "traefik.docker.network" = "traefik_proxy";
      "traefik.http.routers.romm.rule" = "Host(`retro86.gideonwolfe.xyz`)";
      "traefik.http.routers.romm.entrypoints" = "http,https";
      "traefik.http.routers.romm.tls.certresolver" = "myresolver";
      # This was needed to make the port bind correctly when exposing to WAN
      "traefik.http.services.romm.loadbalancer.server.port" = "8080";
    };
    #environmentFiles = [ config.age.secrets.romm_env.path ];
    environmentFiles = [ config.sops.secrets."romm/env".path ];
  };

  virtualisation.oci-containers.containers.romm-db = {
    # using the linuxserver version
    # https://github.com/rommapp/romm/issues/928
    image = "lscr.io/linuxserver/mariadb";
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      DB_HOST = "romm-db";
      # Had to be changed when switching to Linuxserver
      # MARIADB_DATABASE = "romm";
      # MARIADB_USER = "romm-user";
      # MARIADB_PASSWORD = "spunglebrains";
      # MARIADB_ROOT_PASSWORD = "spunglebrains";
      MYSQL_DATABASE = "romm";
      MYSQL_USER = "romm-user";
      MYSQL_PASSWORD = "spunglebrains";
      MYSQL_ROOT_PASSWORD = "spunglebrains";
    };
    volumes = [
      "/home/overseer/server/services/media/romm/romm_database:/var/lib/mysql"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };

  # Set up a backup for my library
  services.restic.backups.romm_library = {
    initialize = true;
    repository = "/run/media/overseer/mnemosyne/backups/games/romm/";
    paths = [ "/pool/data/media/games/roms/romm/library" ];
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
