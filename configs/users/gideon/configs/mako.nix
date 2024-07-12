{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	services.mako = {
		enable = true;
		icons = true;
		textColor = base05;
		#defaultTimeout = 10;
	};
}
