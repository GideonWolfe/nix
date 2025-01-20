{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.slskd = {
    image = "slskd/slskd";
    ports = [ "5030:5030" "5031:5031" "50300:50300" ];
    autoStart = true;
    environment = { SLSKD_REMOTE_CONFIGURATION = "true"; };
    volumes = [ "/home/overseer/server/services/media/slskd/data/data:/app" ];
    extraOptions = [ "--network=traefik_proxy" ];
  };
}
