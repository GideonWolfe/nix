{ config, lib, pkgs, ... }:

{
	home.packages = [

		########
		# DATA #
		########
		pkgs.paraview # data visualization engine
		pkgs.labplot # data visualization engine
	];
}
