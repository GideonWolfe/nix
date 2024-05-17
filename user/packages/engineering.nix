{ config, lib, pkgs, ... }:

{
	home.packages = [


		##########
		# CAD/3D #
		##########
		pkgs.freecad # frontend to math packages
		pkgs.blender # frontend to math packages

		###############
		# ELECTRONICS #
		###############
		pkgs.sigrok-cli # signal analysis software
		pkgs.pulseview # GUI for sigrok
	];
}
