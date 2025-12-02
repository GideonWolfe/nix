{ pkgs, lib, ... }:

{
	programs.eza = {
		enable = true;
		# show status of git files
		git = true;
		icons = "auto";
		extraOptions = [ 
			"-a"
			"-l"
		];
	};
}
