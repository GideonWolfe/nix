{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.kitty = {
		enable = true;

		settings = {
			 window_padding_width = 4;
		};

		# https://sw.kovidgoyal.net/kitty/shell-integration/
		shellIntegration = {
			enableBashIntegration = true;
			enableZshIntegration = true;
			enableFishIntegration = true;
		};
	};
}
