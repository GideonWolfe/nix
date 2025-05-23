{ config, lib, pkgs, ... }:

let asciiMol = pkgs.python312Packages.callPackage ./asciiMol.nix { };
in {
  home.packages = [

    ###########
    # BIOLOGY #
    ###########
    pkgs.jmol # Java Molecular viewer
    pkgs.seaview # DNA alignment and phylogeny gui
    pkgs.gatk # lots of biology utilities
        #asciiMol

  ];
}
