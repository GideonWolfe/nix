{ config, lib, pkgs, ... }:

{
	home.packages = with pkgs; [
		# screensavers
		unimatrix
		asciiquarium
		pipes
		sl
		lavat
		# generate ascii text
		toilet
		figlet
		cowsay
		charasay
		dwt1-shell-color-scripts
		lolcat
		calligraphy # GTK app to preview/generate ASCII
		# Misc
		thokr # typing speedtest in TUI
        # games
        sgt-puzzles
        astrolog # astrology software
		owofetch
	];
}
