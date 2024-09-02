{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		pipewire 
		qpwgraph
		ffmpeg
		alsa-utils # amixer and other utilities
		pavucontrol # PulseAudio control GUI
		playerctl # MPRIS control CLI

        # musicbrainz tagger
        picard
	];
}
