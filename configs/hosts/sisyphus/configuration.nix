{ config, lib, pkgs, inputs, ... }:

{
  # VM configuration for testing desktop roles
  
  # Basic system settings
  networking.hostName = "sisyphus";
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Import v2modules
  imports = [
    ../../v2modules/roles/default.nix
    ../../v2modules/roles/desktop.nix
    ../../v2modules/roles/theming.nix
  ];

  # Enable default system configuration
  defaultRole = {
    enable = true;
  };

  # Enable theming
  stylixTheming = {
    enable = true;
  };

  # Enable desktop role with Hyprland
  desktop = {
    enable = true;
    desktopEnvironment = "hyprland";
    gestures = true;
    users = [ "test" ];
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

  # Basic system packages for testing
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    htop
    tree
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
