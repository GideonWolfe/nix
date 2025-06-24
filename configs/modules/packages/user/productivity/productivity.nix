{ config, lib, pkgs, ... }:
let
  hackernews-tui = pkgs.callPackage ./hackernews-tui.nix { };
  basalt-tui = pkgs.callPackage ./basalt-tui.nix { };
in {
  home.packages = [

    #pkgs.kdePackages.umbrello # UML modeler
    pkgs.authenticator # GNOME 2FA client

    pkgs.concessio # GTK app to understand/convert file permissions

    ##############
    # OFFICE/PDF #
    ##############
    pkgs.libreoffice
    pkgs.zathura # PDF viewer
    pkgs.tdf # TUI PDF viewer
    pkgs.poppler # PDF rendering library
    #pkgs.okular # Documant/PDF viewer
    pkgs.evince # GNOME Documant/PDF viewer
    pkgs.xournalpp # paint.net clone #TODO: theme paper color, etc (need to generate XML)
    pkgs.mdbook # Create books from markdown # lots of extra addons for this, check package list
    pkgs.apostrophe # GNOME Markdown editor
    pkgs.frogmouth # advanced TUI markdown reader
    pkgs.glow # TUI markdown quick previewer
    pkgs.calligra # suite of productivity apps
    pkgs.drawio # desktop version of draw.io
    pkgs.gaphor # python UML modeling tool
    pkgs.foliate # GUI Ebook reader
    pkgs.epy # TUI Ebook reader
    pkgs.sigil # ePub editor
    pkgs.texliveFull # full latex environment
    pkgs.texstudio # LaTeX Editor
    pkgs.visidata # Interactive terminal multitool for tabular data
    pkgs.komikku # GNOME app to discover/read comic books/manga

    #########
    # TASKS #
    #########
    #pkgs.zanshin
    pkgs.dijo
    pkgs.gtg # Getting Things GNOME (offline task manager)
    #pkgs.planify # GTK task manager with nextcloud and todoist support
    pkgs.errands # official GNOME task manager with nextcloud and ics support

    ############
    # CALENDAR #
    ############
    #pkgs.calcurse
    pkgs.calcure # modern calendar TUI
    pkgs.khal
    pkgs.gnome-calendar

    pkgs.gnome-contacts # contacts viewer that can connect to NC or Google

    # TUI timer
    pkgs.peaclock
    pkgs.mpris-timer # GTK Timer
    #pkgs.kronometer # ugly QT timer :(

    # Password manager
    pkgs.keepassxc
    pkgs.seahorse
    pkgs.bitwarden-desktop # connects to vaultwarden

    pkgs.lock # perform arbitrary encrypt/decrypt/signing with PGP keys
    pkgs.gpg-tui # manage GnuPG through the terminal
    pkgs.kdePackages.kgpg # GUI for GPG
    pkgs.sshs # TUI for opening SSH connections
    pkgs.kdePackages.kleopatra # general certificate/encryption suite

    # Emoji selector
    pkgs.wofi-emoji

    # GUI for weather
    pkgs.gnome-weather

    #########
    # UTILS #
    #########
    #pkgs.barcode # barcode generator
    #pkgs.zbar # barcode scanner
    #pkgs.gpick # color picker
    pkgs.translate-shell # google translate in the shell
    pkgs.dialect # GNOME GUI for translating
    pkgs.shell-gpt # CLI for ChatGPT
    pkgs.ov # terminal pager
    pkgs.maim # scrot replacement
    pkgs.kando # pie menu
    pkgs.sc-im # spreadsheet calculator
    pkgs.qrtool # encode/decode QR images
    pkgs.zint # powerful barcode creator
    pkgs.exhibit # GNOME 3D model viewer
    pkgs.filezilla # FTP client
    pkgs.termscp # TUI FTP client
    pkgs.transmission_4-gtk # torrent client
    pkgs.webtorrent_desktop # stream torrents from the web
    pkgs.tartube-yt-dlp # GUI for youtube-dlp
    pkgs.chance # dice roller, binary name is rollit
    pkgs.kiwix # offline viewer for zim files (wikis/docs)
    pkgs.web-archives # offline viewer for zim files (wikis/docs)
    pkgs.goldendict-ng # GUI dictionary with support for web and local files
    pkgs.artha # offline GKT1 thesaurus
    pkgs.wordbook # GNOME dictionary
    pkgs.kdePackages.kruler # Measure pixels on the screen

    # nix tools
    # couple things to access dconf settings and convert them to nix
    pkgs.dconf2nix
    pkgs.dconf-editor
    pkgs.nix-search-tv # fuzzy search nix packages
    pkgs.television # general purpose Fuzzy Finder, should be moved

    #########
    # PHOTO #
    #########
    pkgs.exif # manipulate photo metadata
    pkgs.exiftool # manipulate photo metadata
    #pkgs.kgeotag # standalone geotag editor/viewer #BUG: fails bc marble wont buld
    pkgs.photini # GUI for viewing/editing photo metadata
    pkgs.gifsicle # manipulate gif metadata
    pkgs.gnome-frog # OCR tool
    pkgs.gImageReader # Simple Gtk/Qt front-end to tesseract-ocr
    pkgs.upscayl # local AI image upscaler
    pkgs.upscaler # local GNOME image upscaler
    pkgs.loupe # gnome-image-viewer GUI for light editing and viewing

    ###########
    # FINANCE #
    ###########
    pkgs.cointop # TUI Crypto price tracker
    pkgs.ticker
    pkgs.tickrs
    pkgs.gnucash # basic accounting software
    pkgs.wealthfolio # local finance/portfolio tracker

    # Workspaces and Knowledge Bases
    pkgs.trilium-desktop
    pkgs.affine
    pkgs.obsidian

    #LLM
    pkgs.tenere # llm TUI
    pkgs.llm # LLM CLI
    pkgs.tgpt # LLM CLI
    pkgs.lmstudio # LLM GUI

    # Dashboards
    pkgs.wtfutil
    pkgs.sampler

    hackernews-tui
    basalt-tui

  ];
}
