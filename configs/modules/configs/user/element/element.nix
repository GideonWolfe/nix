{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  xdg.configFile.obsidian-stylix-css = {
    enable = true;
    # THIS VALUE NEEDS TO CHANGE TO YOUR VAULT (relative to your home dir)
    #target = "test/obsidian/.obsidian/snippets/obsidian-stylix-css.css";
    target = "Element/config.json";

    text = ''
      {
        "setting_defaults": {
          "custom_themes": [
            {
              "name": "Stylix",
              "is_dark": true,
              "colors": {
                "accent-color": "${base07}",
                "primary-color": "${base07}",
                "warning-color": "${base08}",
                "alert": "${base0A}",
                "sidebar-color": "${base00}",
                "roomlist-background-color": "${base01}",
                "roomlist-text-color": "${base05}",
                "roomlist-text-secondary-color": "${base02}",
                "roomlist-highlights-color": "${base03}",
                "roomlist-separator-color": "${base04}",
                "timeline-background-color": "${base00}",
                "timeline-text-color": "${base05}",
                "secondary-content": "${base05}",
                "tertiary-content": "${base05}",
                "timeline-text-secondary-color": "${base04}",
                "timeline-highlights-color": "${base01}",
                "reaction-row-button-selected-bg-color": "${base04}",
                "menu-selected-color": "${base03}",
                "focus-bg-color": "${base04}",
                "room-highlight-color": "${base0C}",
                "togglesw-off-color": "${base04}",
                "other-user-pill-bg-color": "${base0E}",
                "username-colors": [
                  "${base0E}",
                  "${base08}",
                  "${base09}",
                  "${base0B}",
                  "${base0C}",
                  "${base0F}",
                  "${base0D}",
                  "${base07}"
                ],
                "avatar-background-colors": [
                  "${base0D}",
                  "${base0E}",
                  "${base0B}"
                ]
              }
            }
          ]
          },
          "show_labs_settings": true
      }
    '';

  };
}
