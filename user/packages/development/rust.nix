{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.rustup
		#pkgs.rustc
		#pkgs.cargo
		#pkgs.rust-analyzer
	];
}
