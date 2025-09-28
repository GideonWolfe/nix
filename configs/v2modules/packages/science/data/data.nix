{ config, lib, pkgs, ... }:
let euporie = pkgs.python312Packages.callPackage ./euporie.nix { };
in {
  home.packages = [

    ########
    # DATA #
    ########
    pkgs.paraview # data visualization engine
    pkgs.labplot # data visualization engine
    pkgs.veusz # data visualization engine
    pkgs.youplot # pipe data and plot in your terminal
    #pkgs.qsv # TUI/CLI data wrangling toolkit #BUG: not building
    #euporie
  ];
}
