{ config, lib, pkgs, ... }:

{
	home.packages = [

		#############
		# ASTRONOMY #
		#############
		pkgs.celestia
		pkgs.kstars
		pkgs.gpredict
        

	];
}
