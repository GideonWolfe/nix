{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.lyrebird # voice changer
    pkgs.halloy # IRC GUI
    pkgs.weechat # IRC TUI
    pkgs.weechatScripts.weechat-notify-send # allow weechat to send notifications
    pkgs.weechatScripts.autosort
    pkgs.weechatScripts.highmon
    pkgs.element-desktop # "official" Matrix GUI
    pkgs.fractal # GNOME Matrix GUI
    #pkgs.gomuks # Matrix TUI #BUG: has a CSV
    pkgs.signal-desktop
    pkgs.gurk-rs # signal TUI
    pkgs.flare-signal # GNOME Signal GUI
    pkgs.neomutt # Email TUI
    #pkgs.discord
    pkgs.vesktop
    pkgs.dissent # GTK Discord client
    #pkgs.betterdiscord-installer
    pkgs.slack
    pkgs.zoom-us
    pkgs.thunderbird
    pkgs.tuba # GTK fediverse/mastadon client

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
