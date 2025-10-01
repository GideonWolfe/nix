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
      ssh.enable = true;
      # WIP
      secrets.enable = true;

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

  # HOST-SPECIFIC TESTING SECTIONS
  # Use these sections to test configurations before generalizing them

  # System-level testing configuration
  # Add system-wide imports, services, packages, etc. here for testing
  # Example:
  # imports = [
  #   ../../modules/configs/system/services/some-test-service.nix
  # ];
  # services.someTestService.enable = true;
  # environment.systemPackages = with pkgs; [ some-test-package ];

  # Home Manager testing configuration for the configured user
  home-manager.users.${config.custom.user.name} = {
    # Add user-specific imports, programs, services, etc. here for testing
    # Example:
    # imports = [
    #   ../../v2modules/configs/user/some-test-config.nix
    # ];
    # programs.someTestProgram.enable = true;
    # home.packages = with pkgs; [ some-test-package ];
  };

  # System state version
  system.stateVersion = "25.05";
}