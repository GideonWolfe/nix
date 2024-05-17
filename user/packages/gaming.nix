{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.steam
		pkgs.protontricks
		pkgs.lutris
	];
}
