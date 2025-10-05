{ pkgs, lib, ... }:

{
	programs.atuin = {
		enable = true;
		enableFishIntegration = true;
		enableBashIntegration = true;
        #enableZshIntegration = true;
	};
}
