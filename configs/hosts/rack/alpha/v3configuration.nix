{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    
    # Disk Partitioning Settings
    ./disko.nix

    # Temporarily import this here
    ../../../v3modules/lib/world.nix

    # Base Level system configuration
    ../../../v3modules/system/core/system.nix

    # Import the gideon user configuration
    ../../../v3modules/users/gideon/gideon.nix

    # Import the abstracted home-manager configuration
    ../../../v3modules/system/core/home-manager.nix

    # Set up stylix for system level theming
    ../../../v3modules/system/core/stylix.nix

    # Import wireguard configuration  #TODO should be imported by default since it only activates if enabled
    ../../../v3modules/system/core/wireguard.nix
    ../../../v3modules/system/core/sops.nix
  ];
  
  # Basic system settings
  networking.hostName = "alpha";

  # Enable WireGuard feature
  custom.features.wireguard.enable = true;
  custom.features.secrets.enable = true;
  custom.features.monitoring.enable = true;

  # Enable sudo without password for convenience during testing
  security.sudo.wheelNeedsPassword = false;

  # System state version
  system.stateVersion = "25.05";
}