{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.lyrebird # voice changer
    pkgs.weechat # IRC TUI
    #pkgs.element-desktop-wayland # Matrix GUI
    #pkgs.signal-desktop
    pkgs.neomutt # Email TUI
    #pkgs.discord
    pkgs.vesktop
    #pkgs.betterdiscord-installer
    #pkgs.slack
    #pkgs.zoom-us
    pkgs.thunderbird

    ########
    # NEWS #
    ########

    # TUI and GUI RSS readers
    pkgs.newsboat
    #pkgs.akregator #Qt RSS reader
    #pkgs.newsflash # GTK RSS reader

    # TUI Podcast client
    #pkgs.castero #Only in unstable
  ];
}
