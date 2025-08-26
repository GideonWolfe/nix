{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.slskd = {
    image = "slskd/slskd";
    ports = [ "5030:5030" "5031:5031" "50300:50300" ];
    autoStart = true;
    user = "1000:100";
    environment = {
      PUID = "1000";
      PGID = "100";
      SLSKD_REMOTE_CONFIGURATION = "true";
      SLSKD_REMOTE_FILE_MANAGEMENT = "true";
      SLSKD_DOWNLOADS_DIR = "/downloads";
      #SLSKD_INCOMPLETE_DIR = "/incomplete";
      SLSKD_UMASK = "022";
    };
    volumes = [
      "/home/overseer/server/services/media/slskd/data/data:/app"
      #"/pool/data/media/downloads/completed/music:/app/downloads"
      #"/pool/data/media/downloads:/app/downloads"
      #"/pool/data/media/downloads:/downloads"
      # "/pool/data/media/downloads:/downloads"
      #"/pool/data/media/downloads/completed/music:/downloads"
      "/home/overseer/test/slskd:/downloads"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
