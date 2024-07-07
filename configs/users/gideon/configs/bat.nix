{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.bat = {
		enable = true;

		#config = {
			#theme = "base16";
		#};

		# TODO there's more advanced themes to configure
		#themes = {};

	};
}
