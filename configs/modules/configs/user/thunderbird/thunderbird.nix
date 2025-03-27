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
            --primary: ${base0D} !important;
            --layout-background-0: ${base00} !important;
            --layout-background-1: ${base01} !important;
            --layout-border-0: ${base01} !important;
            --layout-color-1: ${base05} !important;
            --spaces-bg-color: ${base01} !important;
            --sidebar-background: ${base01} !important;
            --foldertree-background: ${base00} !important;
            --text-color-error: ${base08} !important;
            --text-color-deemphasized: ${base04} !important;
            --error-text-color: ${base08} !important;
            --selected-item-text-color: ${base0E} !important;
            --folderpane-unread-count-text: ${base00} !important;
            --folderpane-unread-new-count-background: ${base0A} !important;
            --folderpane-unread-count-background: ${base0B} !important;
            --icon-color: ${base0D} !important;
            --new-folder-color: ${base0B} !important;
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

            --tree-card-background: ${base00} !important;
            --tree-card-background-selected-current: ${base01} !important;
            --tree-card-background-selected: ${base01} !important;
            --tree-card-border: ${base03} !important;
            --tree-card-border-focus: ${base0E} !important;
            --treeitem-text-active: ${base0E} !important;
            --read-status-fill: transparent !important;
            --read-status-stroke: ${base0D} !important;

            --search-bar-color: ${base01} !important;

            /* should be color of tag icon but getting overriden*/
            --tag-\$label1-backcolor: ${base08} !important;
            --tag-color: ${base08} !important;

            --thread-pane-flag-fill: ${base0A} !important;
            --thread-pane-flag-stroke: ${base0A} !important;

          }

          /* star button for emails when starred*/
          button.email-action-flagged {
            &.flagged {
              fill: ${base0A} !important;
              stroke: ${base0A} !important;
            }
          }
          /* star button for emails when not starred*/
          button.email-action-flagged {
            fill: transparent !important;
            stroke: ${base0A} !important;
          }

          /* color of unread bubble on card */
          #threadTree[rows="thread-card"] {
            & .card-layout {
              &[data-properties~="unread"] {
                --read-status-fill: ${base0B} !important;
                --read-status-stroke: ${base0B} !important;
              }
            }
          }

          /* color of card text */
          #threadTree[rows="thread-card"] {
            & .card-layout {
              & td {
                & .card-container {
                  color: ${base05} !important;
                }
              }
            }
          }

        '';

        userContent = "";
      };
    };
  };
}
