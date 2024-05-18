{ config, lib, pkgs, ... }:

{
	home.packages = [
		# screensavers
		#pkgs.unimatrix #only in unstable
		pkgs.asciiquarium
		pkgs.pipes
		pkgs.sl
		# generate ascii text
		pkgs.toilet
		pkgs.figlet
		pkgs.dwt1-shell-color-scripts
		pkgs.lolcat
	];
}
