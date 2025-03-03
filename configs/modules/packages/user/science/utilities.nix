{ config, lib, pkgs, ... }:

{
	home.packages = [

		#########
		# UTILS #
		#########
		pkgs.zotero # organize research and sources
        pkgs.wiki-tui # TUI for wikipedia
        pkgs.youplot # pipe data and plot in your terminal
        pkgs.surfer # general waveform viewer

	];
}
