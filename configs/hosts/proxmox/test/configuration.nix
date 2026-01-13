{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    
    # Disk Partitioning Settings
    # NOTE: not needed if using manual partitioning during installation
    #./disko.nix

    # Base Level system configuration
    # Imports world data, stylix, home-manager, wireguard, sops, etc
    ../../../v3modules/system/core/system.nix

    # Import the gideon system user configuration
    ../../../v3modules/users/gideon/gideon.nix

    # node custom MOTD for fun SSHing
    #./motd.nix
  ];
  
  #test
  environment.systemPackages = with pkgs; [
    unimatrix
  ];
  
  # Basic system settings
  networking.hostName = "proxmox-test";

  # My roles that can be enabled/disabled per system
  custom.features.wireguard.enable = false;
  custom.features.secrets.enable = false;
  custom.features.monitoring.enable = false;
  custom.features.gaming.enable = false;
  custom.features.proxmox-guest.enable = true;

  # System state version
  system.stateVersion = "25.11";
}