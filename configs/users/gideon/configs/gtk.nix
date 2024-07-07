{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	gtk = {
		enable = true;

		iconTheme = {
			#name = "Papirus";
			name = "ePapirus-dark";
		};

	};
}
