{ config, lib, pkgs, ... }:

{
	home.packages = [


		#############
		# CHEMISTRY #
		#############
		pkgs.kdePackages.kalzium # Periodic table
		pkgs.nucleus # Periodic table
		pkgs.pymol # molecular graphics tool
		pkgs.openmolcas # quantum chemistry software
		pkgs.chemtool # draw chemical structures
		pkgs.avogadro2 # molecular editor enable when space
		pkgs.avogadrolibs # molecular editor enable when space
		pkgs.molsketch # 2D molecular editor
		pkgs.gromacs # molecular dynamics

        # brewing
        pkgs.brewtarget # beer recipe creation tool

	];
}
