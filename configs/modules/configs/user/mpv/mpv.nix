{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
    config = {
      background-color = "${base00}";
      osd-back-color = "${base01}";
      osd-border-color = "${base0E}";
      osd-color = "${base00}";
      osd-shadow-color = "${base00}";
    };
  };

  # control UI needs separate config file
  # https://github.com/mpv-player/mpv/blob/master/DOCS/man/osc.rst
  xdg.configFile.mpv-osc-theme = {
    enable = true;
    target = "mpv/script-opts/osc.conf";
    text = ''
      background_color=${base01}
      timecode_color=${base0D}
      title_color=${base0B}
      time_pos_outline_color=${base0A}
      buttons_color=${base0E}
      top_buttons_color=${base0F}
      small_buttonsL_color=${base08}
      small_buttonsR_color=${base09}
      held_element_color=${base09}

    '';
  };
}
