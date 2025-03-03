{ config, lib, pkgs, ... }:

{
  home.packages = [

    ########
    # MATH #
    ########
    pkgs.cantor # frontend to octave
    pkgs.octave # scientific programming lang
    pkgs.geogebra # graphing calculator
    pkgs.gnuplot # graphing software
    pkgs.maxima # computer algerbra system
    pkgs.libqalculate # advanced calculator
    #pkgs.qalculate-qt # frontend for qalculate
    pkgs.qalculate-gtk # frontend for qalculate

  ];
}
