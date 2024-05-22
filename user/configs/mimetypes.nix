{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	xdg.mimeApps.defaultApplications = {
		"text/html" = ["firefox.desktop"];
		"text/xml" = ["firefox.desktop"];
		"x-scheme-handler/http" = ["firefox.desktop"];
		"x-scheme-handler/https" = ["firefox.desktop"];
	};
}
