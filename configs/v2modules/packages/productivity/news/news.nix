{ config, lib, pkgs, ... }:

{
  home.packages = [

    # TUI and GUI RSS readers
    pkgs.newsboat
    #pkgs.akregator #Qt RSS reader
    pkgs.newsflash # GTK RSS reader
    pkgs.rssguard # KDE RSS reader

  ];
}
