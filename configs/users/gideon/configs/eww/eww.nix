{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.eww = {
		enable = true;
        # configDir = "${config.home.homeDirectory}/nix/configs/users/gideon/configs/eww/config/";
        configDir = ./config;
	};
}
