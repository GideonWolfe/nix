{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.NAME = {
		enable = true;
	};
}
