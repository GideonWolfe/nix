{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.audacity
		#pkgs.spotify
		#pkgs.swaglyrics # TUI spotify lyrics
		pkgs.asunder # CD ripper GUI
		pkgs.easytag # GUI for editing audio metadata
		pkgs.friture # real-time audio analyzer
		pkgs.cmus # TUI music player
		#pkgs.amarok # KDE GUI music player
		pkgs.cava # TUI music visualizer
		pkgs.cavalier # cava based visualizers
		pkgs.blanket # ambient noise player
		#pkgs.reaper # DAW
		#pkgs.piper-tts # Advanced text to speech
		#pkgs.shaq # CLI for Shazam (Song identifier)
		#pkgs.spotdl # Download spotify playlists/metadata
		#pkgs.yabridge # Yabridge for using Windows VSTs
		#pkgs.yabridgectl
		#pkgs.brasero # GNOME CD/DVD burner
	];
}
