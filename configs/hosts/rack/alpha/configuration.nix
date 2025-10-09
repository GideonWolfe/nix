{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    
    # Disk Partitioning Settings
    ./disko.nix

    # Base Level system configuration
    ../../../v3modules/system/core/system.nix

    # Import the gideon system user configuration
    ../../../v3modules/users/gideon/gideon.nix

    # node custom MOTD
    ./motd.nix

    # Common Cluster Configs
    ../common/common.nix

  ];
  
  # Basic system settings
  networking.hostName = "alpha";

  # Enable WireGuard feature
  custom.features.wireguard.enable = true;
  custom.features.secrets.enable = true;
  custom.features.monitoring.enable = true;

  # TEST override keepalive priority
  services.keepalived.vrrpInstances.k3s.priority = lib.mkForce 230;
  
  # Bootstrap the cluster without trying to join
  services.k3s = { 
    clusterInit = lib.mkForce true;  # Initialize the cluster
    serverAddr = lib.mkForce "";     # Don't try to join - this IS the master
  }; 


  # Enable sudo without password for convenience during testing
#  security.sudo.wheelNeedsPassword = false;

  # System state version
  system.stateVersion = "25.05";
}