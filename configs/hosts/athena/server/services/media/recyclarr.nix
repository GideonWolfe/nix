{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.recyclarr = {
    image = "recyclarr/recyclarr";
    autoStart = true;
    environment = { TZ = "America/New_York"; };
    volumes =
      [ "/home/overseer/server/services/media/recyclarr/data/config:/config" ];
    extraOptions = [ "--network=traefik_proxy" ];
  };
    # USAGE: https://recyclarr.dev/wiki/cli/sync/
}
