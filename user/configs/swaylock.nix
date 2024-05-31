{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.swaylock = {
		enable = true;

		package = pkgs.swaylock-effects;

		#settings = {
		#	color = base00;
		#};
	};
}
