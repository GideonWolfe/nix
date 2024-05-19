{ config, lib, pkgs, ... }:

{
	home.packages = [
	
		# UTILITIES #
		pkgs.hexyl # CLI Hex viewer
		pkgs.highlight # highlight code output
		pkgs.jq # CLI JSON parser
		pkgs.lazydocker # TUI docker interface
		pkgs.git
		pkgs.lazygit # TUI git interface

		# IDEs
		#pkgs.vscode

		# GUI
		#pkgs.pencil # Prototyping tool (like figma)

		# Security
		pkgs.radare2
		#pkgs.iaito #radare2 gui
		pkgs.rizin # fork of r2
		pkgs.cutter # rizin gui
		#pkgs.rizinPlugins.rz-ghidra # add ghidra support
		#pkgs.cutterPlugins.rz-ghidra
		# TODO both conflicts when built
		#pkgs.ghidra
		pkgs.ghidra-bin

	];
}
