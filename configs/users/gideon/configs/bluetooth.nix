{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	services.blueman-applet = {
		enable = true;
	};
}
