{ config, lib, pkgs, ... }:

let
  userPackagesDir = ../../../configs/modules/packages/user;
in {
  options.radio = {
    enable = lib.mkEnableOption "Amateur radio tools and services";
    
    hamclock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable HamClock application";
    };

    # Users to configure with radio packages
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to configure with radio package modules";
    };
  };

  config = lib.mkIf config.radio.enable {
    # Import HamClock configuration if enabled
    imports = lib.optionals config.radio.hamclock [
      ../modules/hamclock.nix
    ];

    # Add radio-specific groups to users
    users.users = lib.genAttrs config.radio.users (user: {
      extraGroups = [
        "dialout"  # Access USB ports for radio devices (like chirp)
        "plugdev"  # Needed for RTL-SDR and other radio hardware
      ];
    });

    # Configure specified users with radio packages
    home-manager.users = lib.genAttrs config.radio.users (user: {
      imports = [
        "${userPackagesDir}/science/radio.nix"
        "${userPackagesDir}/science/adsb_deku.nix"
      ];
    });
  };
}
