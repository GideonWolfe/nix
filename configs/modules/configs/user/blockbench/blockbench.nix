{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.blockbench-theme = {
    enable = true;
    target = "Blockbench/stylix.bbtheme";
    text = ''
      {
        "name": "Stylix",
        "author": "Gideon Wolfe",
        "colors": {
          "ui": "${base00}",
          "back": "${base01}",
          "dark": "${base01}",
          "border": "${base04}",
          "selected": "${base03}",
          "button": "${base02}",
          "bright_ui": "${base02}",
          "accent": "${base03}",
          "frame": "${base01}",
          "text": "${base05}",
          "light": "${base04}",
          "accent_text": "${base0E}",
          "bright_ui_text": "${base05}",
          "subtle_text": "${base04}",
          "grid": "${base04}",
          "wireframe": "${base04}",
          "checkerboard": "${base03}"
        }
      }
    '';
  };
}
