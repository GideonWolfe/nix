{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.custom.features.monitoring;
in {
  # imports = [
  # ];

  options.custom.features.gaming = {
    enable = lib.mkEnableOption "Gaming Support";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall =
        true; # Open ports in the firewall for Steam Local Network Game Transfers
      # Enable/install Proton Tricks 
      protontricks.enable = true;
    };
    # Enable Udev rules for controllers and other hardware
    hardware.steam-hardware.enable = true;
    # Enable Xbox controller driver
    hardware.xone.enable = true;


    # Install additional gaming packages
    environment.systemPackages = [
      pkgs.protontricks
      pkgs.lutris
      pkgs.itch
      pkgs.nexusmods-app-unfree
      pkgs.mangohud
      pkgs.jstest-gtk #joystick tester
      pkgs.cutechess # chess engine
      pkgs.maptool # VTT for tabletop games
      pkgs.flips # IPS and BPS patcher (for making romhacks)
      pkgs.flashgbx # GUI for r/w GBA cartridges (with the right hardware)
      pkgs.adwsteamgtk
      pkgs.cartridges # GTK game launcher that can detect other launchers
      pkgs.protonplus # GTK app to manage proton/wine installations
    ];
  };
}
