{ config, lib, pkgs, ... }:

let
  userPackagesDir = ../../../configs/modules/packages/user;
  # Get all normal users on the system
  normalUsers = lib.attrNames (lib.filterAttrs (name: user: user.isNormalUser) config.users.users);
in {
  options.radio = {
    enable = lib.mkEnableOption "Amateur radio tools and services";
    
    hamclock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable HamClock application";
    };
  };

  config = lib.mkIf config.radio.enable {
    # Import radio-specific hardware and services (SYSTEM LEVEL)
    imports = [
      ../modules/configs/system/services/hardware/rtl-sdr.nix
      ../modules/configs/system/services/hardware/hackrf.nix
    ] ++ lib.optionals config.radio.hamclock [
      ../modules/hamclock.nix
    ];

    # Add radio-specific groups to ALL normal users (SYSTEM LEVEL)
    users.users = lib.genAttrs normalUsers (user: {
      extraGroups = [
        "dialout"  # Access USB ports for radio devices (like chirp)
        "plugdev"  # Needed for RTL-SDR and other radio hardware
      ];
    });

    # Configure ALL normal users with radio packages & themes (HOME-MANAGER LEVEL)
    home-manager.users = lib.genAttrs normalUsers (user: {
      imports = [
        "${userPackagesDir}/science/radio.nix"
        "${userPackagesDir}/science/adsb_deku.nix"
      ];
      
      # Radio-specific theming/user configs would go here
      # Example: programs.chirp.theme = "dark";
    });
  };
}
