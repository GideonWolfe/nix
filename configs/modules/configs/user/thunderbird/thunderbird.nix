{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.thunderbird = {
    # individual accounts can be enabled at the accounts.email config level for HM
    enable = true;

    profiles = {
      "gideon" = {
        #name = "default";
        isDefault = true;

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = ''
          :root {
            --spaces-bg-color: ${base01} !important;
            --error-text-color: ${base08} !important;
            --selected-item-text-color: ${base0E} !important;

            --folder-color-inbox: ${base0D} !important;
            --folder-color-draft: ${base0E} !important;
            --folder-color-sent: ${base0B} !important;
            --folder-color-archive: ${base0F} !important;
            --folder-color-spam: ${base08} !important;
            --folder-color-trash: ${base04} !important;
            --folder-color-template: ${base03} !important;
            --folder-color-newsletter: ${base0C} !important;
            --folder-color-rss: ${base09} !important;
            --folder-color-outbox: ${base0C} !important;
            --folder-color-folder: ${base0A} !important;
            --folder-color-folder-filter: ${base07} !important;
            --folder-color-folder-rss: ${base09} !important;
          }
        '';

        userContent = "";
      };
    };
  };
}
