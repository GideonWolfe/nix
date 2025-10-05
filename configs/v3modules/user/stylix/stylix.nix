{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  stylix = {
	targets = {
		# Let our custom spicetify theme handle this
		spicetify.enable = false;
		firefox = { profileNames = [ "default" ]; };
	};
  };
}
