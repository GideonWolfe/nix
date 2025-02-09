{ config, lib, pkgs, ... }:

{
	home.packages = [
		# screensavers
		pkgs.unimatrix
		pkgs.asciiquarium
		pkgs.pipes
		pkgs.sl
		pkgs.lavat
		# generate ascii text
		pkgs.toilet
		pkgs.figlet
		pkgs.cowsay
		pkgs.charasay
		pkgs.dwt1-shell-color-scripts
		pkgs.lolcat
		# Misc
		pkgs.thokr # typing speedtest in TUI
        # games
        pkgs.sgt-puzzles
	];
}
