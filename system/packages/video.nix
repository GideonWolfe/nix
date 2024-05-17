{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# Video Players
		mpv
		vlc
		# converter and DVD ripper
		handbrake 
		# Downloaders
		youtube-dl
		# Take photos through webcam
		gnome.cheese
		neofetch
	];
}
