{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.monica = {
    image = "monica:apache";
    ports = [ "4200:80" ];
    autoStart = true;
    environment = {
      DB_HOST = "monicadb";
      DB_USERNAME = "monica";
      DB_PASSWORD = "test";
    };
    volumes = [
      "/home/overseer/server/services/productivity/monica/datadir:/var/www/html/storage"
    ];
    extraOptions = [ "--network=net_monica" ];
  };

  virtualisation.oci-containers.containers.monicadb = {
    image = "mariadb:11";
    autoStart = true;
    environment = {
      MYSQL_RANDOM_ROOT_PASSWORD = "true";
      MYSQL_DATABASE = "monica";
      MYSQL_USER = "monica";
      MYSQL_PASSWORD = "test";
    };
    volumes = [
      "/home/overseer/server/services/productivity/monica/db:/var/lib/mysql"
    ];
    extraOptions = [ "--network=net_monica" ];
  };
}
