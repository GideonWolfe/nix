{ config, lib, pkgs, ... }:

let dedoc = pkgs.callPackage ./dedoc.nix { };
in {
  home.packages = [

    # UTILITIES #
    pkgs.hexyl # CLI Hex viewer
    pkgs.binsider # CLI Hex viewer
    pkgs.hyx # CLI Hex editor
    pkgs.imhex # GUI Hex editor
    pkgs.biodiff # hex diff viewer
    pkgs.highlight # highlight code output
    pkgs.jq # CLI JSON parser
    pkgs.fx # TUI JSON viewer
    pkgs.jqp # TUI playground for JQ
    pkgs.lazydocker # TUI docker interface
    pkgs.dive # Explore every layer in a docker image
    pkgs.git
    pkgs.lazygit # TUI git interface
    pkgs.gitg # simple GNOME git repo viewer
    pkgs.meld # GUI diff/merge tool
    #pkgs.gh # CLI/TUI for github
    #pkgs.gh-dash # dashboard for gh
    pkgs.wildcard # GUI regex tester
    #pkgs.ngrok # expose local port to WAN
    #pkgs.graphviz # graph visualization software
    pkgs.cloc # count lines of code
    pkgs.lemmeknow # identify anything
    pkgs.mprocs # run multiple processes and show output in the same TUI
    #pkgs.2fa # CLI 2FA client
    pkgs.gource # animate repo history
    pkgs.serie # TUI git log viewer
    pkgs.bitwise # TUI and CLI bitwise operation calc
    pkgs.atac # Postman like API tester (TUI)

    # IDEs
    pkgs.vscode

    # Godot
    pkgs.godot_4

    # GUI
    pkgs.pencil # Prototyping tool (like figma)
    #pkgs.akira # Prototyping / design tool
    #pkgs.gdbgui # browser based GUI for GDB
    pkgs.seer # GDB frontend
    pkgs.harlequin # SQL IDE
    pkgs.zeal # offline docs browser
    pkgs.devdocs-desktop # offline docs browser

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
    pkgs.sherlock # hunt down social media accounts
    #pkgs.john # John the ripper
    #pkgs.metasploit-framework
    #pkgs.johnny # GUI for John the Ripper

    # web dev
    pkgs.sassc

    dedoc
  ];
}
