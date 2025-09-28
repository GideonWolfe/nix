{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [

    ############
    # PAINTING #
    ############
    inkscape-with-extensions
    inkscape-extensions.inkstitch
    krita
    drawing # lightweight drawing app

  ];
}
