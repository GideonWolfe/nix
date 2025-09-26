{ config, lib, pkgs, inputs, ... }:

{
  # Import roles directly - much cleaner!
  imports = [
    ../../modules/roles/desktop.nix
    ../../modules/world.nix
  ];

  # Basic system settings
  networking.hostName = "sisyphus";
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # VM-specific settings
  virtualisation = {
    # Allocate reasonable resources for testing
    memorySize = 4096; # 4GB RAM for monitoring stack
    cores = 2;
    # Enable graphics for GUI testing if needed
    graphics = true;
    # Disk size for the VM
    diskSize = 12288; # 12GB for monitoring data
    # Store VM disk in a specific location instead of current directory
    writableStore = false; # Makes /nix/store read-only
  };

  # Create a test user
  users.users.test = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
  };

  # Enable sudo without password for convenience during testing
  security.sudo.wheelNeedsPassword = false;

  # Set console keymap
  console.keyMap = "us";

  # System state version
  system.stateVersion = "25.05";
}
