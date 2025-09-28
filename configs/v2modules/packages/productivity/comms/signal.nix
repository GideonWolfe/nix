{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
    gurk-rs # signal TUI
    flare-signal # GNOME Signal GUI
  ];
}
