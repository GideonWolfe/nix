{ config, lib, pkgs, ... }:

let
  hackernews-tui = pkgs.callPackage ../custom/hackernews-tui.nix { };
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
    pkgs.signal-desktop
    pkgs.gurk-rs # signal TUI
    pkgs.flare-signal # GNOME Signal GUI

    ###########
    # Discord #
    ###########
    pkgs.vesktop
    pkgs.dissent # GTK Discord client

    ##########
    # Matrix #
    ##########
    pkgs.element-desktop # "official" Matrix GUI
    pkgs.fractal # GNOME Matrix GUI
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
    # BUG tuba compiling from scratch, takes forever
    #pkgs.tuba # GTK fediverse/mastadon client
    hackernews-tui
    pkgs.castero # TUI podcast player
  ];
}
