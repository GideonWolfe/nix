{ config, lib, pkgs, ... }:

{
	home.packages = [
	
		# UTILITIES #
		pkgs.hexyl # CLI Hex viewer
		pkgs.hyx # CLI Hex editor
		pkgs.highlight # highlight code output
		pkgs.jq # CLI JSON parser
		pkgs.lazydocker # TUI docker interface
		pkgs.git
		pkgs.lazygit # TUI git interface
		#pkgs.ngrok # expose local port to WAN
		#pkgs.graphviz # graph visualization software
		#pkgs.cloc # count lines of code
		#pkgs.lemmeknow # identify anything
		#pkgs.mprocs # run multiple processes and show output in the same TUI
		#pkgs.2fa # CLI 2FA client
		pkgs.gource # animate repo history

		# IDEs
		#pkgs.vscode

		# GUI
		#pkgs.pencil # Prototyping tool (like figma)
		#pkgs.akira # Prototyping / design tool

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
		# wifi tools
		#pkgs.aircrack-ng
		#pkgs.airgeddon
		#pkgs.tcpdump # network monitor
		#pkgs.termshark # Wireshark TUI
		#pkgs.wavemon # monitor wifi devices
		#pkgs.qFlipper
		pkgs.gpg-tui # TUI for GnuPG
		#pkgs.john # John the ripper
		#pkgs.metasploit-framework

	];
}
