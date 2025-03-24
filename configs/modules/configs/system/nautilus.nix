{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
    # extension to open terminals
	programs.nautilus-open-any-terminal = {
		enable = true;
		terminal = "kitty";
	};
}
