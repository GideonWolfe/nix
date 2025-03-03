{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.soularr = {
    image = "mrusse08/soularr";
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      SCRIPT_INTERVAL = "300";
    };
    volumes = [
      # pointing at slskd downloads so it can hand them to lidarr
      "/pool/data/media/downloads:/downloads"
    ];
    extraOptions = [ "--network=traefik_proxy" ];
  };

}
