{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.fzf = {
		enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
	};
}
