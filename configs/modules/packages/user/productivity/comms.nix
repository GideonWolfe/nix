{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.lyrebird # voice changer
    pkgs.weechat # IRC TUI
    pkgs.weechatScripts.weechat-notify-send # allow weechat to send notifications
    pkgs.weechatScripts.autosort
    pkgs.weechatScripts.highmon
    pkgs.element-desktop # Matrix GUI
    pkgs.signal-desktop
    pkgs.gurk-rs # signal TUI
    pkgs.neomutt # Email TUI
    #pkgs.discord
    pkgs.vesktop
    #pkgs.betterdiscord-installer
    pkgs.slack
    pkgs.zoom-us
    pkgs.thunderbird

    ########
    # NEWS #
    ########

    # TUI and GUI RSS readers
    pkgs.newsboat
    #pkgs.akregator #Qt RSS reader
    pkgs.newsflash # GTK RSS reader

    # TUI Podcast client
    pkgs.castero # Only in unstable
  ];
}
