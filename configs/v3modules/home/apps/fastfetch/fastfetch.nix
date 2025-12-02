{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.fastfetch = {
		enable = true;
	};
}
