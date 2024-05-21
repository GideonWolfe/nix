{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.obs-studio
		pkgs.obs-studio-plugins.obs-pipewire-audio-capture
	];
}
