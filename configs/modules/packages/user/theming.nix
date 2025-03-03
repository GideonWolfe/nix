{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.spicetify-cli
    # QT utils
    pkgs.libsForQt5.qt5ct
    pkgs.qt6ct
    pkgs.libsForQt5.qtcurve
    pkgs.libsForQt5.qtstyleplugins

    pkgs.papirus-icon-theme
    pkgs.papirus-folders
    pkgs.material-icons

  ];

}
