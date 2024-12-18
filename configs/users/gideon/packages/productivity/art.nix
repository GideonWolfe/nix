{ config, lib, pkgs, ... }:

{
  home.packages = [

    ############
    # PAINTING #
    ############
    pkgs.inkscape
    pkgs.krita

    ###############
    # PHOTOGRAPHY #
    ###############
    pkgs.gimp

    #########
    # MUSIC #
    #########
    pkgs.frescobaldi # lillypond GUI for writing scores
    pkgs.fmit # instrument tuner
    pkgs.fretboard # guitar chord identifier
    pkgs.coltrane # Music calculation GUI/TUI
    #pkgs.transcribe # music player optimized for transcribing music
  ];
}
