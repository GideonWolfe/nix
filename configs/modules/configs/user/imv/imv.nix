{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

  programs.imv = {
    enable = true;
    settings = {
      options = {
        background = "${base00}";
        overlay_text_color = "${base05}";
        overlay_background_color = "${base01}";
      };
    };
  };

}
