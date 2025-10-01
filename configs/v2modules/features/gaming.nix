{ config, lib, pkgs, pathConfig, ... }:

{
  # Always import gaming modules when this feature is loaded
  imports = [
    "${pathConfig.systemModulesDir}/services/gaming/steam.nix"
  ];

  options.custom.features.gaming = {
    enable = lib.mkEnableOption "Gaming support and services";
    
    steam = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam gaming platform";
    };
  };

  config = lib.mkIf config.custom.features.gaming.enable {
    # Enable Steam if requested (the module is already imported)
    programs.steam.enable = lib.mkIf config.custom.features.gaming.steam true;

    # Enable ratbagd for gaming mice support
    services.ratbagd.enable = true;

    # Configure ALL normal users with gaming packages
    home-manager.users = lib.genAttrs 
      (lib.attrNames (lib.filterAttrs (name: user: user.isNormalUser) config.users.users))
      (user: {
        imports = [
          "${pathConfig.packagesDir}/gaming/gaming.nix"
        ];
      });
  };
}
