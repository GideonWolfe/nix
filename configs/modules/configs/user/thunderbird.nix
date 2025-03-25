{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  home.file.thunderbird-theme-manifest = {
    enable = true;
    # THIS VALUE NEEDS TO CHANGE TO YOUR VAULT (relative to your home dir)
    #target = "test/obsidian/.obsidian/snippets/obsidian-stylix-css.css";
    target = "test/thunderbird_theme/manifest.json";

    text = ''
      {
        "manifest_version": 2,
        "name": "Stylix theme",
        "version": "1.0",
        "browser_specific_settings": {
          "gecko": {
            "id": "test@test.com",
            "strict_min_version": "128.0"
          }
        },
        "description": "Dynamic Theme Sourcing Stylix Colors.",
        "theme": {
          "colors": {
            "frame": "${base00}",
            "tab_text": "${base05}",
            "tab_line": "${base0E}",
            "tab_loading": "${base0E}",
            "tab_background_text": "${base05}",
            "bookmark_text": "${base04}",
            "toolbar_field": "${base01}",
            "toolbar_field_text": "${base04}",
            "toolbar_field_highlight": "${base0E}",
            "toolbar_field_highlight_text": "${base05}",
            "toolbar_field_border": "${base0D}",
            "toolbar_field_focus": "${base04}",
            "toolbar_field_text_focus": "${base05}",
            "toolbar_field_border_focus": "${base0E}",
            "toolbar_top_separator": "${base08}",
            "toolbar_bottom_separator": "${base09}",
            "toolbar_vertical_separator": "${base0A}",
            "sidebar": "${base00}",
            "sidebar_text": "${base04}",
            "sidebar_highlight": "rgba(${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b},.6)",
            "sidebar_highlight_text": "${base05}",
            "sidebar_border": "${base0B}",
            "popup": "${base00}",
            "popup_text": "${base04}",
            "popup_border": "${base0A}",
            "popup_highlight": "${base0E}",
            "popup_highlight_text": "${base05}"
          },
          "images": {
            "theme_frame": "${config.stylix.image}"
          }
        }
      }
    '';
  };
}
