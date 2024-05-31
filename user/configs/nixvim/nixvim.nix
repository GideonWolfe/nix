{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.nixvim = {
		enable = true;
		opts = {
			number = true;
		};
	};
}
