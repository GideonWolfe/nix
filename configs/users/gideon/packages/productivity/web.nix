{ config, lib, pkgs, ... }:

{
	home.packages = [
		#pkgs.firefox
		pkgs.w3m
		pkgs.qutebrowser
		#pkgs.transmission # torrent client, switch to transmission-gtk or maybe even transmission_4-gtk if this is bad
        pkgs.miniserve # serve startpage and other apps easily
	];
}
