{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    element-desktop # "official" Matrix GUI
    fractal # GNOME Matrix GUI
    #gomuks # Matrix TUI #BUG: has a CSV
  ];
}
