{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.nextcloud-aio-mastercontainer = {
    image = "nextcloud/all-in-one:latest";
    ports = [ "4210:80" "4211:8080" "4212:8443" ];
    autoStart = true;
    environment = {
      NEXTCLOUD_DATADIR = "/mnt/ncdata";
      NEXTCLOUD_MOUNT = "/mnt/";
    };
    volumes = [
      "/home/overseer/server/services/productivity/nextcloud/aioconfig:/mnt/docker-aio-config"
      "/home/overseer/server/services/productivity/nextcloud/ncdata:/mnt/ncdata"
    ];
    #extraOptions = [ "--network=net_monica" ];
  };
}
