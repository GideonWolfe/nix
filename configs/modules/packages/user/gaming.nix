{ config, lib, pkgs, ... }:

{
  home.packages = [
    #pkgs.steam don't use, use programs.steam.enable instead
    #pkgs.protontricks # enabled within programs.steam.protontricks
    pkgs.lutris
    pkgs.itch
        #pkgs.nexusmods-app-unfree
    #pkgs.mangohud
    #pkgs.jstest-gtk #joystick tester
    #pkgs.cutechess # chess engine
    #pkgs.maptool VTT for tabletop games
    pkgs.flips # IPS and BPS patcher (for making romhacks)
    pkgs.flashgbx # GUI for r/w GBA cartridges (with the right hardware)
    pkgs.adwsteamgtk
    pkgs.cartridges # GTK game launcher that can detect other launchers
    pkgs.protonplus # GTK app to manage proton/wine installations
  ];
}
