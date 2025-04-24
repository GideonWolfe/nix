{ config, lib, pkgs, ... }:

{
  home.packages = [

    pkgs.eyedropper # advanced color picking utility (GNOME)

    ############
    # PAINTING #
    ############
    pkgs.inkscape
    pkgs.krita
    pkgs.drawing # lightweight drawing app

    ############
    # MODELING #
    ############
    pkgs.blockbench # Low-poly 3d modeler

    ##########
    # IMAGES #
    ##########
    pkgs.gimp
    pkgs.letterpress # create ascii art from images
    pkgs.paleta # extract dominant colors from an image

    #########
    # MUSIC #
    #########
    pkgs.frescobaldi # lillypond GUI for writing scores
    #pkgs.fmit # instrument tuner
    pkgs.lingot # instrument tuner
    pkgs.fretboard # guitar chord identifier
    pkgs.coltrane # Music calculation GUI/TUI
    #pkgs.transcribe # music player optimized for transcribing music
    pkgs.glicol-cli # TUI for glicol (coding music)

    ###########
    # FASHION #
    ###########
    pkgs.valentina # Open source sewing pattern drafting software

  ];
}
