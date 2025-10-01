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
    
    # Roles are now auto-imported from the flake!
  ];

  # Enable base system configuration
  system = {
    enable = true;
  };

  # Enable theming
  stylixTheming = {
    enable = true;
    users = hostUsers;
  };

  # Enable secrets (basic example)
  secrets = {
    enable = false;
    # Example: if you had a secrets file at ../../secrets/sisyphus.yaml
    # defaultSopsFile = ../../secrets/sisyphus.yaml;
  };

  # Enable desktop role with Hyprland (user will be auto-detected)
  desktop = {
    enable = true;
    desktopEnvironment = "hyprland";
    gestures = false;
    users = hostUsers;
  };

  # Enable package categories for testing
  packages = {
    enable = true;
    users = hostUsers;
    development = false;
    productivity = false;
    fun = true;
    science = {
      enable = false;
    };
  };

  # Enable audio support
  audio.enable = true;

  # Enable bluetooth for complete desktop testing
  bluetooth.enable = false;

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

  # Host-specific VM packages for testing
  environment.systemPackages = with pkgs; [
    neovim
  ];

  # Enable SSH for remote access during testing
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  # Enable sudo without password for convenience during testing
  security.sudo.wheelNeedsPassword = false;

  # Testing this pattern here for now
  home-manager.users.test.imports = [
    ../../v2modules/configs/user/common.nix
  ];

  # System state version
  system.stateVersion = "25.05";
}