{ config, lib, pkgs, ... }:

let dedoc = pkgs.callPackage ../custom/dedoc.nix { };
in {
  home.packages = [

    # UTILITIES #
    pkgs.highlight # highlight code output
    #pkgs.ngrok # expose local port to WAN
    #pkgs.graphviz # graph visualization software
    pkgs.mprocs # run multiple processes and show output in the same TUI
    #pkgs.2fa # CLI 2FA client
    pkgs.bitwise # TUI and CLI bitwise operation calc
    pkgs.binary # GTK app to do binary calculations

    #####################
    # String Operations #
    #####################
    pkgs.sttr # TUI for string transformation
    pkgs.textpieces # GUI for string transformation
    pkgs.gtkhash # GUI for getting hashes of files
    pkgs.devtoolbox # Common dev tools in GTK GUI (mostly str conversions)

    ##########
    # Docker #
    ##########
    pkgs.docker
    pkgs.docker-compose
    pkgs.lazydocker # TUI docker interface
    pkgs.dive # Explore every layer in a docker image

    #################
    # Code Analysis #
    #################
    pkgs.cloc # count lines of code
    pkgs.lemmeknow # identify anything

    ########
    # JSON #
    ########
    pkgs.jq # CLI JSON parser
    pkgs.fx # TUI JSON viewer
    pkgs.jqp # TUI playground for JQ

    #########
    # Regex #
    #########
    pkgs.wildcard # GUI regex tester
     #pkgs.rexi # TUI regex tester

    ########
    # APIs #
    ########
    pkgs.atac # Postman like API tester (TUI)
    pkgs.posting # Postman like API tester (TUI)

    ###############
    # Hex Editors #
    ###############
    pkgs.hexyl # CLI Hex viewer
    pkgs.binsider # CLI Hex viewer
    pkgs.hyx # CLI Hex editor
    pkgs.imhex # GUI Hex editor
    pkgs.biodiff # hex diff viewer

    #######
    # Git #
    #######
    pkgs.git
    pkgs.lazygit # TUI git interface
    pkgs.gitg # simple GNOME git repo viewer
    pkgs.sourcegit # GUI GIT client
    pkgs.meld # GUI diff/merge tool
    pkgs.serie # TUI git log viewer
    #pkgs.gh # CLI/TUI for github
    #pkgs.gh-dash # dashboard for gh
    pkgs.gource # animate repo history

    #############
    # Databases #
    #############
    pkgs.dblab # TUI client for local and remote databases
    pkgs.harlequin # SQL IDE

    #############
    # Debugging #
    #############
    #pkgs.gdbgui # browser based GUI for GDB
    pkgs.seer # GDB frontend

    ########
    # IDEs #
    ########
    pkgs.vscode

    ########
    # Docs #
    ########
    pkgs.zeal # offline docs browser
    pkgs.devdocs-desktop # offline docs browser
    dedoc

    # Godot
    pkgs.godot_4

    ##########
    # Design #
    ##########
    pkgs.pencil # Prototyping tool (like figma)
    #pkgs.akira # Prototyping / design tool


    # web dev
    pkgs.sassc

    # nix LSP
    pkgs.nil
  ];
}
