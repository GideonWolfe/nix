{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.sillytavern = {
    image = "ghcr.io/sillytavern/sillytavern:1.12.14";
    ports = [ "4404:8000" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      NODE_ENV = "production";
      FORCE_COLOR = "1";
      SILLYTAVERN_WHITELISTMODE = "false";
      SILLYTAVERN_ENABLEFORWARDEDWHITELIST = "false";
      SILLYTAVERN_BASICAUTHMODE = "true";
      #SILLYTAVERN_WHITELIST = "['127.0.0.1', '::1', '172.17.0.1']";
    };
    volumes = [
      # Config dir
      "/home/gideon/.config/sillytavern/config:/home/node/app/config"
      # Data dir
      "/home/gideon/.local/share/sillytavern/data:/home/node/app/data"
      # Plugins dir
      "/home/gideon/.local/share/sillytavern/plugins:/home/node/app/plugins"
      # Extensions dir
      "/home/gideon/.local/share/sillytavern/extensions:/home/node/app/public/scripts/extensions/third-party"
    ];
  };
}
