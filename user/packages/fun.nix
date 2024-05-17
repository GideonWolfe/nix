{ config, lib, pkgs, ... }:

{
	home.packages = [
		#pkgs.unimatrix
		pkgs.asciiquarium
		pkgs.sl
		# generate ascii text
		pkgs.toilet
		pkgs.figlet
		pkgs.dwt1-shell-color-scripts
		pkgs.lolcat
	];
}
