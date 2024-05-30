{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.zathura = {
		enable = true;

		options = {
			recolor = true;
		};
	};
}
