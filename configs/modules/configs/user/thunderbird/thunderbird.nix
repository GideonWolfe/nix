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

        withExternalGnupg = true;

        settings = {
          # Enable userChrome customizations
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Allow remote images to be loaded
          "mailnews.message_display.disable_remote_image" = false;

          # Main app color
          "browser.display.background_color" = "${base00}";
          "browser.display.foreground_color" = "${base05}";
          # Force for all messages
          "browser.display.document_color_use" = 2;

          # Link colors
          "layout.css.visited_links_enabled" = true;
          "browser.visited_color" = "${base0E}";
          "reader.custom_colors.visited-links" = "${base0E}";
          "reader.custom_colors.unvisited-links" = "${base0D}";
          "browser.anchor_color" = "${base0D}";
          "browser.anchor_color.dark" = "${base0E}";

          "font.name.sans-serif.x-western" =
            "${config.stylix.fonts.serif.name}";

          # Color of important tag in mail
          "mailnews.tags.$label1.color" = "${base08}";
          # Work tag
          "mailnews.tags.$label2.color" = "${base09}";
          # Personal tag
          "mailnews.tags.$label3.color" = "${base0B}";
          # To Do Tag
          "mailnews.tags.$label4.color" = "${base0D}";
          # Later Tag
          "mailnews.tags.$label5.color" = "${base0E}";

          "mail.openpgp.allow_external_gnupg" = true;
          "mail.openpgp.fetch_pubkeys_from_gnupg" = true;
        };

        userChrome = ''
          :root {
            --bg-color: ${base01} !important;
            --text-color: ${base05} !important;
            --title-color: ${base0D} !important;
            --primary-color: ${base0D} !important;
            --primary-color-hover: ${base0B} !important;
            --btn-color: ${base05} !important;
            --btn-bg: ${base01} !important;
            --btn-bg-hover: ${base00} !important;
            --popup-bg: ${base02} !important;
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

            --tabs-toolbar-background-color: ${base00} !important;

            --tree-view-bg: ${base00} !important;
            --tree-view-color: ${base05} !important;
            --tree-header-bg: ${base05} !important;
            --thread-pane-spam-fill: ${base00} !important;
            --thread-pane-spam-stroke: ${base08} !important;
            --thread-pane-unread-fill: ${base00} !important;
            --thread-pane-unread-stroke: ${base0B} !important;

            --tree-card-background: ${base00} !important;
            --tree-card-background-selected-current: ${base01} !important;
            --tree-card-background-selected: ${base01} !important;
            --tree-card-background-current-spam: ${base00} !important;
            --tree-card-background-selected-current-spam: ${base00} !important;
            --tree-card-border-hover-spam: ${base08} !important;
            --tree-card-border-selected-spam: ${base08} !important;

            --indicator-border-selected-spam: ${base08} !important;
            --indicator-background-selected-spam: ${base08} !important;

            --tree-card-border: ${base03} !important;
            --tree-card-border-focus: ${base0E} !important;
            --tree-card-border-hover: ${base0B} !important;
            --treeitem-text-active: ${base0E} !important;
            --treeitem-background-selected: ${base01} !important;
            --read-status-fill: transparent !important;
            --read-status-stroke: ${base0D} !important;

            --list-indicator-background-selected-focused: ${base0A} !important;
            --list-indicator-background-selected-current: ${base09} !important;



            --thread-pane-flag-fill: ${base0A} !important;
            --thread-pane-flag-stroke: ${base0A} !important;


            --search-bar-border-color: ${base0B} !important;
            --search-focus-outline-color: ${base0E} !important;

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


          /* color of buttons in email notifications */
          /* TODO find theme that works (and not just hover) */
          .notification-button {
            &:not([disabled]):hover {
              color: ${base0B} !important;
              background-color: ${base00} !important;
            }
          }

          /* color of warning in email like spam*/
          :host(notification-message[type="warning"]).text-content, div.container, div.content {
            --message-bar-background-color: ${base0A} !important;
            --message-bar-text-color: ${base00} !important;
            border-radius: 0px !important;
          }



        '';

        userContent = "";
      };
    };
  };
}
