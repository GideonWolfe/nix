{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# Video Players
		mpv
		mpvScripts.mpris #make mpv use mpris
		vlc
		# converter and DVD ripper
		handbrake 
		# Downloaders
		yt-dlp #better youtube-dl
		# Take photos through webcam
		gnome.cheese
		neofetch
	];
}
