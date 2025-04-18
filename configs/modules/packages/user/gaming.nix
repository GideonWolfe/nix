{ config, lib, pkgs, ... }:

{
  home.packages = [
    #pkgs.steam don't use, use programs.steam.enable instead
    #pkgs.protontricks # enabled within programs.steam.protontricks
    pkgs.lutris
    pkgs.itch
    pkgs.nexusmods-app-unfree
    #pkgs.mangohud
    #pkgs.jstest-gtk #joystick tester
    #pkgs.cutechess # chess engine
    #pkgs.maptool VTT for tabletop games
    pkgs.flips # IPS and BPS patcher (for making romhacks)
    pkgs.adwsteamgtk
  ];
}
