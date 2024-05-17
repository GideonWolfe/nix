{ pkgs, lib, ... }:

{
	programs.eza = {
		enable = true;
		# show status of git files
		git = true;
		icons = true;
	};
}
