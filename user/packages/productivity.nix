{ config, lib, pkgs, ... }:

{
	home.packages = [
		
		#pkgs.kdePackages.umbrello # UML modeler

		##############
		# OFFICE/PDF #
		##############
		pkgs.zathura # PDF viewer
		pkgs.poppler # PDF rendering library
		pkgs.okular # Documant/PDF viewer
		pkgs.xournalpp # paint.net clone

		#pkgs.calligra # suite of productivity apps
		#pkgs.gaphor # python UML modeling tool

		#########
		# TASKS #
		#########
		#pkgs.zanshin
		pkgs.dijo

		############
		# CALENDAR #
		############
		pkgs.calcurse

		# TUI timer
		pkgs.peaclock

		# Password manager
		pkgs.keepassxc

		# Emoji selector
		pkgs.wofi-emoji
	];
}
