{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.lyrebird # voice changer
    pkgs.neomutt # Email TUI
    pkgs.vesktop
    pkgs.dissent # GTK Discord client
    pkgs.slack
    pkgs.zoom-us
    pkgs.thunderbird
    pkgs.tuba # GTK fediverse/mastadon client

    # TUI Podcast client
    pkgs.castero # Only in unstable
  ];
}
