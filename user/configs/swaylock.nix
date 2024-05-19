{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.swaylock = {
		enable = true;

		#settings = {
		#	color = base00;
		#};
	};
}
