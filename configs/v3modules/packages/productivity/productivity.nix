{ config, lib, pkgs, inputs, ... }:
let
  basalt-tui = pkgs.callPackage ../custom/basalt-tui.nix { };
  hackernews-tui = pkgs.callPackage ../custom/hackernews-tui.nix { };
in {
  home.packages = [

    #pkgs.kdePackages.umbrello # UML modeler

    pkgs.concessio # GTK app to understand/convert file permissions

    ##########
    # OFFICE/#
    ##########
    pkgs.libreoffice
    pkgs.xournalpp # paint.net clone #TODO: theme paper color, etc (need to generate XML)
    pkgs.calligra # suite of productivity apps
    

    ################
    # Spreadsheets #
    ################
    pkgs.visidata # Interactive terminal multitool for tabular data
    pkgs.sc-im # spreadsheet calculator
    
    #################
    # Documentation #
    #################
    pkgs.kiwix # offline viewer for zim files (wikis/docs)
    pkgs.web-archives # offline viewer for zim files (wikis/docs)

    #######
    # PDF #
    #######
    pkgs.zathura # PDF viewer
    pkgs.tdf # TUI PDF viewer
    pkgs.poppler # PDF rendering library
    #pkgs.okular # Documant/PDF viewer
    pkgs.evince # GNOME Documant/PDF viewer

    ############
    # Diagrams #
    ############
    pkgs.drawio # desktop version of draw.io
    pkgs.gaphor # python UML modeling tool
    
    ############
    # Markdown #
    ############
    pkgs.apostrophe # GNOME Markdown editor
    pkgs.frogmouth # advanced TUI markdown reader
    pkgs.glow # TUI markdown quick previewer
    pkgs.mdbook # Create books from markdown # lots of extra addons for this, check package list

    #########
    # LaTeX #
    #########
    pkgs.texliveFull # full latex environment
    pkgs.texstudio # LaTeX Editor

    ##########
    # ebooks #
    ##########
    pkgs.epy # TUI Ebook reader
    pkgs.sigil # ePub editor
    pkgs.foliate # GUI Ebook reader
    pkgs.komikku # GNOME app to discover/read comic books/manga

    ######################
    # Dict and Thesaurus #
    ######################
    pkgs.goldendict-ng # GUI dictionary with support for web and local files
    pkgs.artha # offline GKT1 thesaurus
    pkgs.wordbook # GNOME dictionary

    #########
    # TASKS #
    #########
    #pkgs.zanshin
    pkgs.dijo
    pkgs.gtg # Getting Things GNOME (offline task manager)
    #pkgs.planify # GTK task manager with nextcloud and todoist support
    pkgs.errands # official GNOME task manager with nextcloud and ics support

    #####################
    # Clocks and Timers #
    #####################
    pkgs.peaclock
    pkgs.mpris-timer # GTK Timer
    #pkgs.kronometer # ugly QT timer :(

    #######################
    # Calendar / Contacts #
    #######################
    #pkgs.calcurse
    pkgs.calcure # modern calendar TUI
    pkgs.khal
    pkgs.gnome-calendar
    pkgs.gnome-contacts # contacts viewer that can connect to NC or Google


    ############
    # Security #
    ############
    pkgs.keepassxc
    pkgs.seahorse
    pkgs.bitwarden-desktop # connects to vaultwarden
    pkgs.authenticator # GNOME 2FA client
    

    ########################
    # Signing / Encrypting #
    ########################
    pkgs.lock # perform arbitrary encrypt/decrypt/signing with PGP keys
    pkgs.gpg-tui # manage GnuPG through the terminal
    #pkgs.kdePackages.kgpg # GUI for GPG # #BUG: this was autostarting
    pkgs.kdePackages.kleopatra # general certificate/encryption suite


    # GUI for weather
    pkgs.gnome-weather

    pkgs.sshs # TUI for opening SSH connections

    ###############
    # Downloaders #
    ###############
    pkgs.filezilla # FTP client
    pkgs.termscp # TUI FTP client
    pkgs.transmission_4-gtk # torrent client
    pkgs.webtorrent_desktop # stream torrents from the web
    pkgs.tartube-yt-dlp # GUI for youtube-dlp

    #######################
    # Encoding / Decoding #
    #######################
    pkgs.qrtool # encode/decode QR images
    pkgs.zint # powerful barcode creator
    #pkgs.barcode # barcode generator
    #pkgs.zbar # barcode scanner

    #########
    # UTILS #
    #########
    #pkgs.gpick # color picker
    pkgs.translate-shell # google translate in the shell
    pkgs.dialect # GNOME GUI for translating
    pkgs.ov # terminal pager
    pkgs.maim # scrot replacement
    pkgs.kando # pie menu
    pkgs.exhibit # GNOME 3D model viewer
    pkgs.chance # dice roller, binary name is rollit
    pkgs.kdePackages.kruler # Measure pixels on the screen
    pkgs.wofi-emoji # emoji selector

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
    # Finance #
    ###########
    pkgs.cointop # TUI Crypto price tracker
    pkgs.ticker
    pkgs.tickrs
    pkgs.gnucash # basic accounting software
    pkgs.wealthfolio # local finance/portfolio tracker

    ########
    # News #
    ########
    pkgs.newsboat # TUI RSS reader
    #pkgs.akregator #Qt RSS reader
    pkgs.newsflash # GTK RSS reader
    pkgs.rssguard # KDE RSS reader
    hackernews-tui

    #########
    # Wikis #
    #########
    pkgs.trilium-desktop
    pkgs.affine
    pkgs.obsidian
    basalt-tui



    #######
    # Web #
    #######
    chromium
    w3m
    qutebrowser
    miniserve # serve startpage and other apps easily
    amfora # TUI gemini browser
    tor-browser


    # Dashboards
    pkgs.wtfutil
    pkgs.sampler


  ];
}
