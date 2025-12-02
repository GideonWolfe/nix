{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

{
  # Defines hackernews_tui theme
  xdg.configFile.hackernews-tui = {
    enable = true;
    target = "hn-tui.toml";
    text = ''
      [theme.palette]
      background = "${base00}"
      foreground = "${base06}"
      selection_background = "${base01}"
      selection_foreground = "${base09}"
      black = "${base01}"
      blue = "${base0D}"
      cyan = "${base0C}"
      green = "${base0B}"
      magenta = "${base0E}"
      red = "${base08}"
      white = "${base05}"
      yellow = "${base0A}"
      light_black = "${base00}"
      light_white = "${base05}"
      light_red = "${base08}"
      light_magenta = "${base0E}"
      light_green = "${base0B}"
      light_cyan = "${base0C}"
      light_blue = "${base0D}"
      light_yellow = "${base0A}"

      [theme.component_style]
      # styl for application's specific components
      title_bar = { back = "${base09}", front = "${base00}", effect = "bold" }
      matched_highlight = { front = "${base00}", back = "${base0A}"}
      metadata = { front = "${base04}" }
      username = { effect = "bold" }
      loading_bar = { front = "${base0A}", back = "${base00}"}

      # general component styles
      quote = { front = "${base0B}" }
      single_code_block = { front = "${base0E}", back = "${base00}"}
      multiline_code_block = { front = "${base0E}", effect = "bold" }
      link = { front = "${base0D}" }
      link_id = { front = "${base00}", back = "${base0A}"}

      current_story_tag = { front = "${base09}" }

    '';
  };
}
