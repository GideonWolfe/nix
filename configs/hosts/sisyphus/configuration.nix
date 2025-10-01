{ config, lib, pkgs, inputs, ... }:

{
  # VM configuration for testing desktop features
  
  # Basic system settings
  networking.hostName = "sisyphus";


  # Feature set for this system
  custom = {
    # Configure the primary user for this system using a preset
    user = config.custom.userPresets.gideon;

    features = {
      system.enable = true;
      theming.enable = true;
      audio.enable = true;
      bluetooth.enable = false;
      # WIP
      secrets.enable = false;

      desktop = {
        enable = true;
        gestures = false;
        desktopEnvironment = "hyprland";
      };

      packages = {
        enable = true;
        development = false;
        productivity = false;
        fun = true;
        science = {
          enable = false;
        };
      };
    };
  };


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