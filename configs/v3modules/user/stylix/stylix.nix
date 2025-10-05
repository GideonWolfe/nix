{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  stylix = {
	# Enable stylix for Home Manager integrations
	enable = true;
	polarity = "dark";
	targets = {
		# Let our custom spicetify theme handle this
		spicetify.enable = false;
		# Tell Stylix to use our default profile
		firefox = { profileNames = [ "default" ]; };
		# Enable QT theming since it's disabled by default
		qt.enable = true;
	};
  };
}
