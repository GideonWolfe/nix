{ config, lib, pkgs, pathConfig, ... }:

{
  imports = [
    # Always import basic radio hardware modules
    "${pathConfig.systemModulesDir}/services/hardware/rtl-sdr.nix"
    "${pathConfig.systemModulesDir}/services/hardware/hackrf.nix"
  ] ++ lib.optionals (config.radio.hamclock or false) [
    # Conditionally import hamclock
    "${pathConfig.systemModulesDir}/services/hamclock.nix"
  ];

  options.radio = {
    enable = lib.mkEnableOption "Amateur radio tools and services";
    
    hamclock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable HamClock application";
    };
  };

  config = lib.mkIf config.radio.enable {
    # Add radio-specific groups to ALL normal users (SYSTEM LEVEL)
    users.users = lib.genAttrs 
      (lib.attrNames (lib.filterAttrs (name: user: user.isNormalUser) config.users.users))
      (user: {
        extraGroups = [
          "dialout"  # Access USB ports for radio devices (like chirp)
          "plugdev"  # Needed for RTL-SDR and other radio hardware
        ];
      });

    # Configure ALL normal users with radio packages & themes (HOME-MANAGER LEVEL)
    home-manager.users = lib.genAttrs 
      (lib.attrNames (lib.filterAttrs (name: user: user.isNormalUser) config.users.users))
      (user: {
        imports = [
          "${pathConfig.userPackagesDir}/science/radio/radio.nix"
          "${pathConfig.userPackagesDir}/science/radio/adsb_deku.nix"
        ];
        
        # Radio-specific theming/user configs would go here
        # Example: programs.chirp.theme = "dark";
      });
  };
}
