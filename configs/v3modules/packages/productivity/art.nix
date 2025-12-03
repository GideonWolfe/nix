{ config, lib, pkgs, ... }:

{
  home.packages = [

    pkgs.eyedropper # advanced color picking utility (GNOME)

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
    pkgs.pigment # extract dominant colors from an image

    ###########
    # FASHION #
    ###########
    pkgs.valentina # Open source sewing pattern drafting software

    ############
    # PAINTING #
    ############
    inkscape-with-extensions
    inkscape-extensions.inkstitch
    krita
    drawing # lightweight drawing app

  ];
}
