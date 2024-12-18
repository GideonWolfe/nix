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
		pkgs.seahorse

		# Emoji selector
		pkgs.wofi-emoji

		#########
		# UTILS #
		#########
		#pkgs.barcode # barcode generator
		#pkgs.zbar # barcode scanner
		#pkgs.gpick # color picker
		pkgs.translate-shell # google translate in the shell
		pkgs.shell-gpt # CLI for ChatGPT
		pkgs.ov # terminal pager
        pkgs.maim # scrot replacement
        pkgs.kando # pie menu
        pkgs.sc-im # spreadsheet calculator
        pkgs.qrtool # encode/decode QR images

		#########
		# PHOTO #
		#########
		#pkgs.exif # manipulate photo metadata
		#pkgs.gifsicle # manipulate gif metadata

		###########
		# FINANCE #
		###########
		pkgs.cointop # TUI Crypto price tracker
        pkgs.ticker
        pkgs.tickrs
		

        # Workspaces and Knowledge Bases
        pkgs.trilium-desktop
        pkgs.affine

	];
}
