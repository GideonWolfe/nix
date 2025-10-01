{ config, lib, pkgs, pathConfig, ... }:

{
  imports = [
    # Always import radio hardware and service modules
    "${pathConfig.systemModulesDir}/services/hardware/rtl-sdr.nix"
    "${pathConfig.systemModulesDir}/services/hardware/hackrf.nix"
    #"${pathConfig.systemModulesDir}/services/hamclock.nix"
  ];

  options.custom.features.radio = {
    enable = lib.mkEnableOption "Amateur radio tools and services";
  };

  config = lib.mkIf config.custom.features.radio.enable {
    # Add radio-specific groups to the system user (SYSTEM LEVEL)
    users.users.${config.custom.user.name}.extraGroups = [
      "dialout"  # Access USB ports for radio devices (like chirp)
      "plugdev"  # Needed for RTL-SDR and other radio hardware
    ];

    # Configure the system user with radio packages & themes (HOME-MANAGER LEVEL)
    home-manager.users.${config.custom.user.name} = {
      imports = [
        "${pathConfig.packagesDir}/science/radio/radio.nix"
        "${pathConfig.packagesDir}/science/radio/adsb_deku.nix"
      ];
      
      # Radio-specific theming/user configs would go here
      # Example: programs.chirp.theme = "dark";
    };
  };
}
