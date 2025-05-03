{ config, lib, pkgs, ... }:

{
	home.packages = [

		#########
		# UTILS #
		#########
		pkgs.zotero # organize research and sources
        pkgs.wiki-tui # TUI for wikipedia
        pkgs.wike # GNOME wikipedia browser
        pkgs.youplot # pipe data and plot in your terminal
        pkgs.surfer # general waveform viewer
        pkgs.citations # GTK app for managing bibtex
        pkgs.gnome-recipes # need a better place for this
        pkgs.hieroglyphic # GTK app to draw/find latex symbols

	];
}
