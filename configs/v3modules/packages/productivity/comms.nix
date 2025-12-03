{ config, lib, pkgs, ... }:

let
  hackernews-tui = pkgs.callPackage ./hackernews-tui.nix { };
in
{
  home.packages = [
    pkgs.lyrebird # voice changer
    pkgs.slack
    pkgs.zoom-us

    #########
    # Email #
    #########
    pkgs.neomutt # Email TUI
    pkgs.thunderbird

    ##########
    # Signal #
    ##########
    signal-desktop
    gurk-rs # signal TUI
    flare-signal # GNOME Signal GUI

    ###########
    # Discord #
    ###########
    pkgs.vesktop
    pkgs.dissent # GTK Discord client

    ##########
    # Matrix #
    ##########
    element-desktop # "official" Matrix GUI
    fractal # GNOME Matrix GUI
    #gomuks # Matrix TUI #BUG: has a CSV

    #######
    # IRC #
    #######
    pkgs.halloy # IRC GUI
    pkgs.weechat # IRC TUI
    pkgs.weechatScripts.weechat-notify-send # allow weechat to send notifications
    pkgs.weechatScripts.autosort
    pkgs.weechatScripts.highmon

    ################
    # Social Media #
    ################
    pkgs.tuba # GTK fediverse/mastadon client
    hackernews-tui
    pkgs.castero # TUI podcast player
  ];
}
