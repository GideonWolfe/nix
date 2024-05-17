{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.rustup
		#pkgs.rust-analyzer
	];
}
