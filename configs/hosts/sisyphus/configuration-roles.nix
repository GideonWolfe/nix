{ config, lib, pkgs, inputs, ... }:

{
  # Import the role system and existing modules
  imports = [
    ../../modules/role-system.nix
    ../../modules/world.nix
    # Import your existing dedicated modules
    ../../modules/configs/system/services/audio/pipewire.nix
  ];

  # Enable roles using options - much cleaner and composable!
  roles = {
    desktop = true;     # Enable desktop environment
    development = true; # Enable development tools
  };

  # Basic system settings
  networking.hostName = "sisyphus";
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # VM-specific settings
  virtualisation = {
    # Allocate reasonable resources for testing
    memorySize = 4096; # 4GB RAM
    cores = 2;
    # Enable graphics for GUI testing if needed
    graphics = true;
    # Disk size for the VM
    diskSize = 12288; # 12GB
    # Store VM disk in a specific location instead of current directory
    writableStore = false; # Makes /nix/store read-only
  };

  # Create a test user and add to groups based on enabled roles
  users.users.test = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ] 
      ++ lib.optional config.roles.development "docker";
  };

  # Enable sudo without password for convenience during testing
  security.sudo.wheelNeedsPassword = false;

  # Set console keymap
  console.keyMap = "us";

  # System state version
  system.stateVersion = "25.05";
}
