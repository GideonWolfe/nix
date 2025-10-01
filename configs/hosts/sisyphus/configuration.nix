{ config, lib, pkgs, inputs, ... }:

let
  # Define users for this host once
  hostUsers = [ "test" ];
in {
  # VM configuration for testing desktop roles
  
  # Basic system settings
  networking.hostName = "sisyphus";

  # Import v2modules
  imports = [
    # Import the global test user definition
    ../../v2modules/users/test.nix
  ];

  # Testing this pattern here for now
  home-manager.users.test.imports = [
    ../../v2modules/configs/user/common.nix
  ];

  # Feature set for this system
  custom.features = {
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
  };


  # Enable package categories for testing
  custom.features.packages = {
    enable = true;
    users = hostUsers;
    development = false;
    productivity = false;
    fun = true;
    science = {
      enable = false;
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