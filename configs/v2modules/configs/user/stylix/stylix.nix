{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  stylix = {
	# Let our custom spicetify theme handle this
	targets = {
		spicetify.enable = false;
		firefox = { profileNames = [ "default" ]; };
	};
  };
}
