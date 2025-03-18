{ config, lib, pkgs, ... }:

{
  home.packages = [

    #pkgs.kdePackages.umbrello # UML modeler

    ##############
    # OFFICE/PDF #
    ##############
    pkgs.libreoffice
    pkgs.zathura # PDF viewer
    pkgs.poppler # PDF rendering library
    pkgs.okular # Documant/PDF viewer
    pkgs.xournalpp # paint.net clone #TODO: theme paper color, etc (need to generate XML)
    pkgs.mdbook # Create books from markdown # lots of extra addons for this, check package list
    pkgs.calligra # suite of productivity apps
    pkgs.gaphor # python UML modeling tool
    pkgs.foliate # GUI Ebook reader
    pkgs.texliveFull # full latex environment
    pkgs.texstudio # LaTeX Editor
    pkgs.visidata # Interactive terminal multitool for tabular data

    #########
    # TASKS #
    #########
    #pkgs.zanshin
    pkgs.dijo

    ############
    # CALENDAR #
    ############
    #pkgs.calcurse
    pkgs.calcure # modern calendar TUI
    pkgs.khal

    # TUI timer
    pkgs.peaclock
    pkgs.mpris-timer # GTK Timer
    #pkgs.kronometer # ugly QT timer :(

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
    pkgs.exhibit # GNOME 3D model viewer
    pkgs.filezilla # FTP client
    pkgs.transmission_4-gtk # torrent client
    pkgs.chance # dice roller, binary name is rollit
    pkgs.kiwix # offline viewer for zim files (wikis/docs)

    #########
    # PHOTO #
    #########
    pkgs.exif # manipulate photo metadata
    pkgs.gifsicle # manipulate gif metadata
    pkgs.gnome-frog # OCR tool

    ###########
    # FINANCE #
    ###########
    pkgs.cointop # TUI Crypto price tracker
    pkgs.ticker
    pkgs.tickrs

    # Workspaces and Knowledge Bases
    pkgs.trilium-desktop
    pkgs.affine
    pkgs.obsidian

    #LLM
    pkgs.tenere # llm TUI
    pkgs.llm # LLM CLI
    pkgs.tgpt # LLM CLI

  ];
}
