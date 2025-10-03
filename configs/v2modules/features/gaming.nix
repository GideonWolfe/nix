{ config, lib, pkgs, pathConfig, ... }:

{
  options.custom.features.gaming = {
    enable = lib.mkEnableOption "Gaming support and services";
    
    steam = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam gaming platform";
    };
  };

  config = lib.mkIf config.custom.features.gaming.enable {
    # Enable Steam with all relevant options
    programs.steam = lib.mkIf config.custom.features.gaming.steam {
      enable = true;
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;
      # Open ports in the firewall for Steam Local Network Game Transfers
      localNetworkGameTransfers.openFirewall = true;
      # Enable/install Proton Tricks 
      protontricks.enable = true;
    };

    # Enable Udev rules for controllers and other hardware
    hardware.steam-hardware.enable = lib.mkIf config.custom.features.gaming.steam true;
    
    # Enable Xbox controller driver
    hardware.xone.enable = true;

    # Enable ratbagd for gaming mice support
    services.ratbagd.enable = true;

    # Configure the designated user with gaming packages
    home-manager.users.${config.custom.user.name} = {
      imports = [
        "${pathConfig.packagesDir}/gaming/gaming.nix"
      ];
    };
  };
}
