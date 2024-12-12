{ config, lib, pkgs, ... }:

{
	home.packages = [

		########
		# MATH #
		########
		pkgs.cantor # frontend to math packages
		pkgs.geogebra # graphing calculator
		pkgs.gnuplot # graphing software
		pkgs.maxima # computer algerbra system
		pkgs.libqalculate # advanced calculator
		pkgs.qalculate-qt # frontend for qalculate

	];
}
