{ config, lib, pkgs, pathConfig, ... }:

{
  imports = [ ];

  options.music_production = {
    enable = lib.mkEnableOption "Local Music Production Software and Services";

  };

  config = lib.mkIf config.music_production.enable {

    # Configure ALL normal users with radio packages & themes (HOME-MANAGER LEVEL)
    home-manager.users = lib.genAttrs (lib.attrNames
      (lib.filterAttrs (name: user: user.isNormalUser) config.users.users))
      (user: {
           # We should be importing the music_production programs

      });
  };
}
