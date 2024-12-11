{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		pipewire 
        pulseaudio # included to get pactl, not actually running via hardware.pulseaudio
		qpwgraph
		ffmpeg
		alsa-utils # amixer and other utilities
		pavucontrol # PulseAudio control GUI
		playerctl # MPRIS control CLI
	];
}
