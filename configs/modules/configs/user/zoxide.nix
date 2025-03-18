{ pkgs, lib, ... }:

{
	programs.zoxide = {
		enable = true;
		enableFishIntegration = true;
		enableBashIntegration = true;
		#enableZshIntegration = true;
	};
}
