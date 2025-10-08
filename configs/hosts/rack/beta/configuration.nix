{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    
    # Disk Partitioning Settings
    ./disko.nix

    # Base Level system configuration
    ../../../v3modules/system/core/system.nix

    # Import the gideon system user configuration
    ../../../v3modules/users/gideon/gideon.nix


    # Common Cluster Configs
    ../common/common.nix

  ];
  
  # Basic system settings
  networking.hostName = "beta";

  # Enable WireGuard feature
  custom.features.wireguard.enable = true;
  custom.features.secrets.enable = true;
  custom.features.monitoring.enable = true;

  # Testing: Hardcode to not init
  services.k3s.clusterInit = lib.mkForce false;

  services.keepalived.vrrpInstances.k3s.priority = lib.mkForce 75;

  # Enable sudo without password for convenience during testing
#  security.sudo.wheelNeedsPassword = false;

  # System state version
  system.stateVersion = "25.05";
}