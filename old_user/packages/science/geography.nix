{ config, lib, pkgs, ... }:

{
	home.packages = [

		#############
		# GEOGRAPHY #
		#############
		pkgs.marble # virtual globe
		#pkgs.mapscii # tui braille map
		pkgs.qgis # GIS software
		pkgs.gpx-viewer # GUI for GPX files (location tracking)
		pkgs.grass # geospatial data management and analysis
		pkgs.survex # cave mapping software

	];
}
