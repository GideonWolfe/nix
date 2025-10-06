{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.gnuplot = {

    enable = true;
    target = "gnuplot/gnuplotrc";
    text = ''
      # Basic configs
      set grid
      set isosamples 50
      set hidden3d

      # Draw a background
      set object rectangle from screen 0,0 to screen 1,1 behind fillcolor rgb '${base00}' fillstyle solid noborder

      # Color some lines
      set linetype 1 lw 2 lc rgb '${base0B}' pointtype 6
      set linetype 2 lw 2 lc rgb '${base05}' pointtype 6
      set linetype 3 lw 2 lc rgb '${base0E}' pointtype 6

      # Key and border colors
      set border lw 3 lc rgb '${base0F}'
      set key textcolor rgb '${base0D}'
      set xlabel "X" textcolor rgb '${base0C}'
      set ylabel "Y" textcolor rgb '${base0C}'
    '';
  };
}
