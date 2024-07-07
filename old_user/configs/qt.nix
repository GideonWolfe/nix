{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	qt = {
		enable = true;
		# disabled until they figure out qt theming, these env vars can get messy
		#platformTheme = "qtct";
	};
}
