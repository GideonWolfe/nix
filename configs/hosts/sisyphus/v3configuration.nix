{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Import the gideon user configuration
    ../../v3modules/users/gideon/gideon.nix
  ];
  
  # Basic system settings
  networking.hostName = "sisyphus";

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