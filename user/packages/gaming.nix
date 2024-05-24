{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.steam
		pkgs.protontricks
		pkgs.lutris
		#pkgs.mangohud
		#pkgs.jstest-gtk #joystick tester
		#pkgs.cutechess # chess engine
	];
}
