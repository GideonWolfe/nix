{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	gtk = {
		enable = true;

		iconTheme = {
            # these are in /run/current-system/sw/share/icons
			name = "breeze-dark";
            package = pkgs.libsForQt5.breeze-icons;
		};

	};
}
