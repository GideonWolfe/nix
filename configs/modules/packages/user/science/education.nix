{ config, lib, pkgs, ... }:

{
	home.packages = [

		#############
		# EDUCATION #
		#############
		pkgs.anki # flash card system
		pkgs.aldo # Learn morse code
		pkgs.minuet # Learn music theory
		pkgs.solfege # Learn music theory
	];
}
