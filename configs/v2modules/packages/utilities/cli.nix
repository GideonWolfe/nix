{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [

    # Terminals
    alacritty
    foot # default wayland/sway term
    kitty

    # Navigation
    tree
    eza # better ls (formerly exa)
    zoxide # better cd
    tmux
    screen

    bat # better cat
    bat-extras.batman
    bat-extras.batpipe
    bat-extras.batgrep
    bat-extras.batdiff
    bat-extras.batwatch
    bat-extras.prettybat

    # Utilities
    csview # cat out CSV files
    fd # better find
    lnav # logfile viewer
    sysz # fzf for systemctl
    moreutils # additional unix tools
    fzf
    tldr # better man pages with examples

    pstree # process tree

    fishPlugins.done


  ];

}
