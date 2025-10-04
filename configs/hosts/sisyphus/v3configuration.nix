{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Import the gideon user configuration
    ../../v3modules/users/gideon/gideon.nix

    # Set up stylix for system level theming
    ../../v3modules/system/stylix.nix

    # Import wireguard configuration  #TODO should be imported by default since it only activates if enabled
    ../../v3modules/system/wireguard.nix
    ../../v3modules/system/sops.nix
  ];
  
  # Basic system settings
  networking.hostName = "sisyphus";

  # Enable WireGuard feature
  custom.features.wireguard.enable = true;
  custom.features.secrets.enable = true;

  # VM-specific settings
  virtualisation = {
    # Allocate reasonable resources for testing
    memorySize = 4096; # 4GB RAM for desktop environment
    cores = 4;
    # Enable graphics for GUI testing
    graphics = true;
    # Disk size for the VM
    diskSize = 16384; # 16GB for desktop apps
  };


  # Enable sudo without password for convenience during testing
  security.sudo.wheelNeedsPassword = false;

  # System state version
  system.stateVersion = "25.05";
}