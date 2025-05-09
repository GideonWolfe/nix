{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.swappy = {

    enable = true;
    target = "swappy/config";
    text = ''
      [Default]
      save_dir=$HOME/pictures/screenshots/
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png
      show_panel=true
      line_size=5
      text_size=20
      text_font=sans-serif
      paint_mode=brush
      early_exit=false
      fill_shape=false
      auto_save=false
      custom_color=rgba(${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b},1)
    '';
  };
}
