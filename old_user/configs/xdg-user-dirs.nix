{ pkgs, lib, ... }:

{

	# Enable User Dirs
	xdg.userDirs.enable = true;

	xdg.userDirs.videos = "$HOME/videos";
	xdg.userDirs.pictures = "$HOME/pictures";
	xdg.userDirs.music = "$HOME/music";
	xdg.userDirs.download = "$HOME/downloads";
	xdg.userDirs.documents = "$HOME/documents";
	# shouldn't be used
	xdg.userDirs.desktop = "$HOME/desktop";
	xdg.userDirs.publicShare = "$HOME/public";
	xdg.userDirs.templates = "$HOME/templates";

}
