{ config, lib, pkgs, pathConfig, ... }:

{
  imports = [
    # Always import radio hardware and service modules
    "${pathConfig.systemModulesDir}/services/hardware/rtl-sdr.nix"
    "${pathConfig.systemModulesDir}/services/hardware/hackrf.nix"
    "${pathConfig.systemModulesDir}/services/hamclock.nix"
  ];

  options.radio = {
    enable = lib.mkEnableOption "Amateur radio tools and services";
    
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to configure with radio tools";
    };
  };

  config = lib.mkIf config.radio.enable {
    # Add radio-specific groups to specified users (SYSTEM LEVEL)
    users.users = lib.genAttrs config.radio.users (user: {
      extraGroups = [
        "dialout"  # Access USB ports for radio devices (like chirp)
        "plugdev"  # Needed for RTL-SDR and other radio hardware
      ];
    });

    # Configure specified users with radio packages & themes (HOME-MANAGER LEVEL)
    home-manager.users = lib.genAttrs config.radio.users (user: {
        imports = [
          "${pathConfig.packagesDir}/science/radio/radio.nix"
          "${pathConfig.packagesDir}/science/radio/adsb_deku.nix"
        ];
        
        # Radio-specific theming/user configs would go here
        # Example: programs.chirp.theme = "dark";
      });
  };
}
