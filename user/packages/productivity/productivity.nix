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
		#pkgs.mdbook # Create books from markdown # lots of extra addons for this, check package list
		#pkgs.calligra # suite of productivity apps
		#pkgs.gaphor # python UML modeling tool
		pkgs.foliate # GUI Ebook reader
		#pkgs.texliveFull # full latex environment
		#pkgs.texstudio # LaTeX Editor

		#########
		# TASKS #
		#########
		#pkgs.zanshin
		pkgs.dijo

		############
		# CALENDAR #
		############
		pkgs.calcurse
		#pkgs.calcure # modern calendar TUI
		pkgs.khal

		# TUI timer
		pkgs.peaclock
		pkgs.kronometer

		# Password manager
		pkgs.keepassxc
		pkgs.gnome.seahorse

		# Emoji selector
		pkgs.wofi-emoji

		#########
		# UTILS #
		#########
		#pkgs.barcode # barcode generator
		#pkgs.zbar # barcode scanner
		#pkgs.gpick # color picker
		pkgs.translate-shell # google translate in the shell
		pkgs.shell_gpt # CLI for ChatGPT

		#########
		# PHOTO #
		#########
		#pkgs.exif # manipulate photo metadata
		#pkgs.gifsicle # manipulate gif metadata



	];
}
