{ pkgs, lib, ... }:

{

	programs.git = {

		# Allow HM to configure git
		enable = true;

		userName = "Gideon Wolfe";
		userEmail = "wolfegideon@gmail.com";

		# https://github.com/github/gitignore
		#ignores = {}

		hooks = {
			#TODO this should point to another dir
			#post-commit = $HOME/nix/user/scripts/git/post-commit-hook.sh
			#post-commit = home/gideon/nix/user/scripts/git/post-commit-hook.sh;
			post-commit = ./post-commit-hook.sh;
		};
	};
}
