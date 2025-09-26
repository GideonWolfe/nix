{ config, lib, pkgs, inputs, ... }:

{
  # Minimal VM configuration for testing
  
  # Basic system settings
  networking.hostName = "sisyphus";
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # VM-specific settings
  virtualisation = {
    # Allocate reasonable resources for testing
    memorySize = 2048; # 2GB RAM
    cores = 2;
    # Enable graphics for GUI testing if needed
    graphics = true;
    # Disk size for the VM
    diskSize = 8192; # 8GB
  };

  # Basic system packages for testing
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    htop
    tree
  ];

  # Enable SSH for remote access during testing
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
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
