{ config, lib, pkgs, ... }:

let
  asciiMol = pkgs.python312Packages.callPackage ./asciiMol.nix { };
  plascad = pkgs.callPackage ./plascad.nix { };
  #ugene = pkgs.callPackage ./ugene.nix { }; # BUG: failing build
in {
  home.packages = [

    ###########
    # BIOLOGY #
    ###########
    pkgs.jmol # Java Molecular viewer
    pkgs.seaview # DNA alignment and phylogeny gui
    pkgs.gatk # lots of biology utilities
    #asciiMol
    plascad
    #ugene

  ];
}
