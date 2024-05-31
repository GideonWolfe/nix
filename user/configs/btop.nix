{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.btop = {
		enable = true;
		settings = {
			color_theme = "TTY";
		};
	};
}
