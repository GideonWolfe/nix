{ config, lib, pkgs, ... }:

{
  home.packages = [
    #########
    # UTILS #
    #########
    pkgs.zotero # organize research and sources
    pkgs.anki # flash cards
    pkgs.wiki-tui # TUI for wikipedia
    pkgs.wike # GNOME wikipedia browser
    pkgs.surfer # general waveform viewer
    pkgs.citations # GTK app for managing bibtex
    pkgs.gnome-recipes # need a better place for this
    pkgs.hieroglyphic # GTK app to draw/find latex symbols
  ];
}
