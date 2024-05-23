{ config, lib, pkgs, ... }:

{
	home.packages = [
		#pkgs.firefox
		pkgs.w3m
		pkgs.qutebrowser
	];
}
