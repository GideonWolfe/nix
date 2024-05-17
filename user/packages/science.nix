{ config, lib, pkgs, ... }:

{
	home.packages = [

		#############
		# ASTRONOMY #
		#############
		pkgs.celestia
		pkgs.kstars

		###########
		# BIOLOGY #
		###########
		pkgs.jmol # Java Molecular viewer


		############
		# MEDECINE #
		############
		# WHY CANT THIS BE FOUND?
		#pkgs.weasis # DICOM viewer

		###########
		# PHYSICS #
		###########
		#pkgs.kdePackages.step # basic physics simulator

		#############
		# CHEMISTRY #
		#############
		pkgs.kalzium # Periodic table
		pkgs.pymol # molecular graphics tool
		pkgs.openmolcas # quantum chemistry software
		pkgs.chemtool # draw chemical structures

		########
		# MATH #
		########
		pkgs.cantor # frontend to math packages
		#pkgs.geogebra # graphing calculator
		pkgs.gnuplot # graphing software
		pkgs.maxima # computer algerbra system
		pkgs.libqalculate # advanced calculator
		pkgs.qalculate-qt # frontend for qalculate

		#############
		# GEOGRAPHY #
		#############
		pkgs.marble # virtual globe
		#pkgs.mapscii # tui braille map
		pkgs.qgis # GIS software
		pkgs.gpx-viewer # GUI for GPX files (location tracking)
		pkgs.grass # geospatial data management and analysis
		pkgs.survex # cave mapping software

		###########
		# GENERAL #
		###########
		pkgs.paraview # data visualization engine
		pkgs.labplot # data visualization engine
		pkgs.zotero # organize research and sources
		pkgs.anki # flash card system
	];
}
