{ config, lib, pkgs, ... }:

let
  userPackagesDir = ../../../configs/modules/packages/user;
in {
  options.gaming = {
    enable = lib.mkEnableOption "Gaming support and services";
    
    steam = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam gaming platform";
    };

    # Users to configure with gaming packages
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to configure with gaming package modules";
    };
  };

  config = lib.mkIf config.gaming.enable {
    # Import gaming-specific services
    imports = lib.optionals config.gaming.steam [
      ../modules/configs/system/services/gaming/steam.nix
    ];

    # Enable ratbagd for gaming mice support
    services.ratbagd.enable = true;

    # Configure specified users with gaming packages
    home-manager.users = lib.genAttrs config.gaming.users (user: {
      imports = [
        "${userPackagesDir}/gaming.nix"
      ];
    });
  };
}
