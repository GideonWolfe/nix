{ config, lib, pkgs, ... }:

{
	# Let home manager manage this folder
	home.file.wallpapers.enable = true;
	home.file.wallpapers.target = "pictures/wallpapers";
	home.file.wallpapers.recursive = true;
	#home.file.wallpapers.source = pkgs.fetchFromGitHub {
	#	owner = "gideonwolfe";
	#	repo = "wallpapers";
	#	rev = "577f1a735f28705d9124b341721a61aaf06c6b2d";
	#	sha256 = null;
	#};
	home.file.wallpapers.source = builtins.fetchGit {
		url = "https://github.com/gideonwolfe/wallpapers";
		rev = "577f1a735f28705d9124b341721a61aaf06c6b2d";
	};

}
