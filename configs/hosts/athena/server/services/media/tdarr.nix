{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.tdarr = {
    image = "ghcr.io/haveagitgat/tdarr";
    ports = [ "4213:8265" "4214:8266" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      serverIP = "0.0.0.0";
      serverPort = "8266";
      webUIPort = "8265";
      internalNode = "true";
      inContainer = "true";
      ffmpegVersion = "6";
      nodeName = "athenaNode";
      TZ = "America/New_York";
    };
    volumes = [
      "/home/overseer/server/services/media/tdarr/data/configs:/app/configs"
      "/home/overseer/server/services/media/tdarr/data/logs:/app/logs"
      "/home/overseer/server/services/media/tdarr/data/server:/app/server"
      "/home/overseer/server/services/media/tdarr/data/cache:/temp"
      "/pool/data/media:/media"
    ];
    extraOptions =
      [ "--network=traefik_proxy" "--device=/dev/dri:/dev/dri" ];
  };

}
