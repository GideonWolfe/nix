{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.kitty = {
		enable = true;

		settings = {
			 window_padding_width = 4;
		};
        
		keybindings = {
			 "ctrl+shift+n" = "new_os_window_with_cwd";
		};

		# https://sw.kovidgoyal.net/kitty/shell-integration/
		shellIntegration = {
			enableBashIntegration = true;
			enableZshIntegration = true;
			enableFishIntegration = true;
		};
	};
}
