{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.audacity
		#pkgs.spotify
		pkgs.asunder # CD ripper GUI
		pkgs.easytag # GUI for editing audio metadata
		pkgs.friture # real-time audio analyzer
		pkgs.cmus # TUI music player
		pkgs.cava # TUI music visualizer
		pkgs.cavalier # cava based visualizers
		pkgs.blanket # ambient noise player
		#pkgs.reaper # DAW
	];
}
