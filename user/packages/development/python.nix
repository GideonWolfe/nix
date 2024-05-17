{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.python311Packages.pandas
		pkgs.python311Packages.biopandas
		pkgs.python311Packages.geopandas
	];
}
