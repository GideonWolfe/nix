{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    itch
    nexusmods-app-unfree
    #mangohud
    #jstest-gtk #joystick tester
    #cutechess # chess engine
    #maptool VTT for tabletop games
    flips # IPS and BPS patcher (for making romhacks)
    flashgbx # GUI for r/w GBA cartridges (with the right hardware)
    adwsteamgtk
    cartridges # GTK game launcher that can detect other launchers
    protonplus # GTK app to manage proton/wine installations
    antimicrox # GUI for mapping buttons on input devices
    steamcontroller # drivers for the steam controller
  ];
}
