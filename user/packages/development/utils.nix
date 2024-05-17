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

	];
}
