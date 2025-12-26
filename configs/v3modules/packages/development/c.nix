{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.gcc
		pkgs.gnumake
	];
}
