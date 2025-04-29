{ config, lib, pkgs, ... }:

{
  home.packages = [

    #############
    # GEOGRAPHY #
    #############
    pkgs.marble # virtual globe
    pkgs.gnome-maps
    #pkgs.mapscii # tui braille map
    pkgs.globe-cli # TUI globe
    pkgs.qgis # GIS software
    pkgs.gpx-viewer # GUI for GPX files (location tracking)
    pkgs.gpxsee # GUI for GPX files (location tracking)
    pkgs.viking # GPS data editor and analyzer
    #pkgs.grass # geospatial data management and analysis
    pkgs.survex # cave mapping software
    pkgs.satellite # view data from GPS

  ];
}
