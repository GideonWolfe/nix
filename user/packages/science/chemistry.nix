{ config, lib, pkgs, ... }:

{
	home.packages = [


		#############
		# CHEMISTRY #
		#############
		pkgs.kalzium # Periodic table
		pkgs.pymol # molecular graphics tool
		pkgs.openmolcas # quantum chemistry software
		pkgs.chemtool # draw chemical structures

	];
}
