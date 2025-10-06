{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    
    # Disk Partitioning Settings
    ./disko.nix

    # Base Level system configuration
    ../../../v3modules/system/core/system.nix

    # Import the gideon system user configuration
    ../../../v3modules/users/gideon/gideon.nix


    # TESTING
    ../common/keepalived.nix
    ../common/k3s.nix

    ../common/charts/helm-dashboard/helm-dashboard.nix

  ];
  
  # Basic system settings
  networking.hostName = "alpha";

  # Enable WireGuard feature
  custom.features.wireguard.enable = true;
  custom.features.secrets.enable = true;
  custom.features.monitoring.enable = true;

  # Enable sudo without password for convenience during testing
#  security.sudo.wheelNeedsPassword = false;

  # System state version
  system.stateVersion = "25.05";
}