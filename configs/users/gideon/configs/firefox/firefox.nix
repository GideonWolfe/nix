{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.firefox = {
    enable = true;

    # Change policies from https://mozilla.github.io/policy-templates/
    policies = {
      AppAutoUpdate = false;
      DisablePocket = true;
      DisableTelemetry = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisableProfileImport =
        true; # Purity enforcement: Only allow nix-defined profiles
      DisableProfileRefresh =
        true; # Disable the Refresh Firefox button on about:support and support.mozilla.org
      DisableSetDesktopBackground =
        true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image, because Nix is the only thing that can manage the backgroud
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      FirefoxHome = {
        "Search" = true;
        "TopSites" = true;
        "SponsoredTopSites" = false;
        "Highlights" = false;
        "Pocket" = false;
        "SponsoredPocket" = false;
        #"Snippets" = true | false,
        #"Locked" = true | false
      };
      ShowHomeButton = true;

      FirefoxSuggest = {
        "WebSuggestions" = true;
        "SponsoredSuggestions" = false;
        "ImproveSuggest" = true;
        #"Locked" = true | false
      };

      ExtensionSettings = {
        # Ublock Origin
        "uBlock0@raymondhill.net" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          "default_area" = "menupanel";
        };

        # Vimium
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          "default_area" = "menupanel";
        };
        # Keepa (amazon price tracker)
        "amptra@keepa.com" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/keepa/latest.xpi";
          "default_area" = "menupanel";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          "default_area" = "menupanel";
        };
        # New Tab Override
        "newtaboverride@agenedia.com" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
          "default_area" = "menupanel";
        };
        # Bitwarden password manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          "default_area" = "menupanel";
        };
        # Floccus bookmarks
        "floccus@handmadeideas.org" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
          "default_area" = "menupanel";
        };
        # Floccus bookmarks
        "addon@hoarder.app" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/hoarder/latest.xpi";
          "default_area" = "menupanel";
        };
      };

    };

    profiles = {
      # test profile I'm building from scratch
      default = {

        name = "default";

        # set this to a predictable number
        id = 0;

        # Make it the default profile
        isDefault = true;

        # https://kb.mozillazine.org/About:config_entries
        settings = {

          "general.autoScroll" = true;

          # Change browser homepage
          "browser.startup.homepage" = "http://localhost:9876";

          # Enable userChrome.css styling
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Enable stylix fonts #TODO this isn't working
          "font.name.serif.x-western" = "${config.stylix.fonts.serif.name}";

          # The background of pages/text that don't declare one (such as skeleton HTML sites)
          "browser.display.background_color" = "${base00}";
          "browser.display.foreground_color" = "${base05}";
          "browser.display.use_focus_colors" = true;
          "browser.display.focus_background_color" = "${base01}";
          "browser.display.focus_text_color" = "${base04}";

          #TODO test!! disables documents from setting their own colors
          "browser.display.use_document_colors" = false;
          "browser.display.use_document_fonts" = 0;

          # active/unvisited/visited links (if not otherwise themed)
          "browser.active_color" = "${base0C}";
          "browser.anchor_color" = "${base0D}";
          "browser.visited_color" = "${base0B}";

          # For thunderbird (n/a I think)
          "editor.background_color" = "${base00}";
          "editor.use_custom_colors" = true;

          # Selected text
          "ui.textSelectBackground" = "${base05}";
          "ui.textSelectForeground" = "${base00}";

          # Highlight text
          "ui.textHighlightBackground" = "${base05}";
          "ui.textHighlightForeground" = "${base00}";

          # Set the colors of the reader mode
          "reader.color_scheme" = "custom";
          "reader.custom_colors.background" = "${base00}";
          "reader.custom_colors.foreground" = "${base05}";
          "reader.custom_colors.selection-highlight" = "${base0E}";
          "reader.custom_colors.unvisited-links" = "${base0B}";
          "reader.custom_colors.visited-links" = "${base08}";

          # Colors available when using highlighter tool in PDF
          "pdfjs.highlightEditorColors" =
            "yellow=${base0A},green=${base0B},blue=${base0D},pink=${base0E},red=${base08}";

          # Use neovim to view source
          "view_source.editor.external" = true;
          "view_source.editor.path" = "${pkgs.neovim}/bin/nvim";

          # Some style settings
          "browser.chrome.favicons" = false;

          # enable debugging of firefox chrome through inspector
          "devtools.chrome.enabled" = true;
          "devtools.debugger.remote-enabled" = true;

          # Change colors of PDFJS pdf reader
          "pdfjs.forcePageColors" = true;
          "pdfjs.pageColorsBackground" = "${base00}";
          "pdfjs.pageColorsForeground" = "${base05}";

          # allow plugins on all pages
          "extensions.webextensions.restrictedDomains" = "";
          "extensions.webextensions.restrictedDomains.enabled" = false;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
        };

        # TODO this is a cleaner way of structuring things,
        # plus you get the syntax highlighting in a .css file
        # only issue is since it isn't a nix file, we can't template out colors
        #userChrome = builtins.readFile ./userChrome.css;

        userContent = ''
              
              /* anything here gets applied universally to every page and element */
              :root {
                      /* PDF.js tweaks, might specify class further if it causes issues*/
                      --body-bg-color: ${base01} !important;
                      --field-bg-color: ${base01} !important;
                      --toolbar-bg-color: ${base00} !important;
                      --toolbar-icon-bg-color: ${base0B} !important;
                      --toolbar-border-color: ${base0E} !important;
                      --sidebar-toolbar-bg-color: ${base01} !important;
                      --toggled-btn-color: ${base09} !important;
                      --toggled-btn-bg-color: ${base01} !important;
                      --dropdown-btn-bg-color: ${base00} !important;
                      --main-color: ${base05} !important;
                      --text-color: ${base05} !important;
                      --doorhanger-bg-color: ${base00} !important;
                      --treeitem-color: ${base09} !important;
                      --treeitem-selected-color: ${base0E} !important;
                      --treeitem-hover-color: ${base0B} !important;
                      --button-hover-color: ${base0A} !important;

                      /* tweaks to "firefox view" page */
                     --fxview-background-color: ${base00} !important;
                     --fxview-background-color-secondary: ${base01} !important;
                     --fxview-primary-action-background: ${base0D} !important;
                     --fxview-border: ${base0F} !important;
                     --page-nav-button-text-color: ${base0A} !important;
                     --button-text-color: ${base05} !important;

              }
              /* current page number in PDF*/
              .toolbarField {
                      color: ${base0A} !important;
              }
              /* drop down menu for zooming in PDF reader */
              .dropdownToolbarButton {
                      color: ${base05} !important;
                      background-color: ${base00} !important;
                      border: 1px solid ${base0E} !important;
              }

              .editorParamsSlider {
                background-color: ${base0E};
              }

              /* styling for all input boxes (fixes search on FF view page )*/
              input {
                      color: ${base05} !important;
                      background-color: ${base01} !important;
              }
              /* x symbol in input bars */
              .search-container {
                      color: ${base08} !important;
              }


              /* styling to apply to all about: pages */
              /* https://github.com/ATechnocratis/widefox/blob/main/chrome/userContent-files/aboutpages/about_pages_Darker.css */
              @-moz-document url-prefix("about:"),
              url-prefix("chrome://userchromejs/content/aboutconfig/aboutconfig.xhtml"),url-prefix(view-source)  {
                  :root {
                      --primary-background: ${base00} !important;
                      --bg-color: ${base00} !important;
                      --secondary-background: ${base01} !important;
                      --primary-font-color: ${base05} !important;
                      --background-color-box: ${base01} !important;
                      --highlighted-font-color: ${base00} !important;
                      --primary-border: 1px solid ${base0E} !important;
                      --bright-border: 1px solid ${base0A} !important;
                      --border-color: ${base0D} !important;
                      --bright-border-color: ${base0A} !important;
                      --primary-icon-color: ${base05} !important;
                      --faded-bright-border-color: rgba(${base0A-rgb-r}, ${base0A-rgb-g}, ${base0A-rgb-b}, .65) !important;
                      --in-content-border-focus: ${base0E} !important;
                      --in-content-border-color: ${base09} !important;
                      /* --primary-accent-color: ${base0D} !important; */
                      --color-accent-primary: ${base0E} !important;
                      --color-accent-primary-hover: ${base0D} !important;
                      --in-content-page-background: ${base00};
                      --in-content-page-color: ${base05} !important;
                      --in-content-box-background-alt: ${base01} !important;
                      --in-content-box-info-background: ${base00} !important;
                      --in-content-button-background: ${base01} !important;
                      --in-content-button-background-alt: ${base00} !important;
                      --in-content-box-border-color: ${base01} !important;
                      --in-content-box-background: ${base00} !important;
                      --in-content-box-background-op: rgba(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b}, 0.5) !important;
                      --in-content-primary-button-background: ${base0D} !important;
                      --in-content-primary-button-background-hover: ${base0B} !important;
                      --in-content-primary-button-background-active: ${base0C} !important;
                      --in-content-text-color: ${base05} !important;
                      --in-content-focus-outline-color: ${base09} !important;
                      --search-box: ${base00} !important;
                      --checkbox-checked-color: ${base0B} !important;
                      --in-content-item-selected: ${base0B} !important;
                      --in-content-primary-button-text-color: var(--highlighted-font-color) !important;
                      --in-content-category-text-hover: HighlightText  !important;
                      --in-content-category-background-hover: Highlight  !important;
                      --in-content-category-text-selected: ${base00}  !important;
                      --in-content-category-text-selected: ${base05}  !important;
                      --in-content-category-background-selected: ${base01} !important;

                      /* color of toggle button nubs and other toggle colors*/
                      --background-color-canvas: ${base00} !important;
                  }
                  @media (min-width: 830px) {
                      :root {
                          --in-content-page-background: ${base00}!important;
                      }
                  } 
              }

              /* specific styling for about:preferences */
              @-moz-document url-prefix("about:preferences") {
                  h1 {
                      font-size: 1.5em!important;
                      font-weight: 900 !important;
                  }
                  .main-content {
                      background-color: ${base00} !important;
                      color: ${base05}!important;
                  }
                  .sticky-container {
                      background-color: ${base00} !important;
                  }
                  #categories>.category[selected], #categories>.category.selected {
                      color: ${base08} !important;
                  }
                  html, h1, #categories {
                      color: ${base05} !important;
                  }
                  .navigation, #handersView, #engineShown, #engineName, #engineKeyword, .dialogTitleBar {
                      background-color: ${base01} !important;
                      color: ${base05} !important;
                  }
                  #searchInput {
                      background-color: ${base01} !important;
                      color: ${base09} !important;
                  }
                  #filter {
                      background-color: ${base01} !important;
                      color: ${base09} !important;
                  }
                  #downloadFolder {
                      background-color: ${base01} !important;
                      color: ${base09} !important;
                  }
                  #typeColumn {
                      background-color: ${base01} !important;
                      color: ${base09} !important;
                  }
                  #actionColumn {
                      background-color: ${base01} !important;
                      color: ${base09} !important;
                  }
                  #handlersView {
                      background-color: ${base01} !important;
                      color: ${base05} !important;
                  }
                  #applicationsGroup listheader {
                      background-color: ${base01} !important;
                  }
                  #contentBlockingOptionStandard, #contentBlockingOptionStrict, #contentBlockingOptionCustom {
                      background-color: ${base01} !important;
                      color: ${base05} !important;
                      border: 0px  !important;
                  }
                  description {
                      color: ${base05} !important;
                  }
                  #engineChildren {
                      background-color: ${base01} !important;
                      color: ${base05} !important;
                  }
                  .content-blocking-warning {
                      background: ${base01} !important;
                  }
                  .checkbox-check, input[type="checkbox"] {
                      border: 1px dashed var(--in-content-accent-color)  !important;
                      background-color: transparent  !important;
                      -moz-appearance: none  !important;
                      opacity: 0.7 !important;
                  }
                  .checkbox-check[checked] {
                      opacity: 1 !important;
                  }
                  input[type="checkbox"] {
                      border: 1px dashed ${base0D}  !important;
                      background-color: transparent  !important;
                      -moz-appearance: none  !important;
                  }
                  .radio-check {
                      background-color: transparent  !important;
                  }
              }

              /* specific styling for addons manager */
              @-moz-document url-prefix("about:addons") {
                  #sidebar {
                      background-color: ${base01};
                  }
                  #full {
                      color: ${base05} !important;
                  }
                  .card {
                      background-color: ${base01} !important;
                      color: ${base05} !important;
                  }
                  #searchInput {
                      background-color: ${base01} !important;
                      color: ${base09} !important;
                  }
              }

              /* specific styling for debugging page */
              @-moz-document url-prefix(about:debugging) {
                  :root {
                      --bg-color: ${base00} !important;
                      --box-background: ${base01} !important;
                      --box-border-color: ${base0D} !important;
                      --text-color: ${base05} !important;
                      --caption-20-color: ${base05} !important;
                      --sidebar-selected-color: ${base05} !important;
                      --card-separator-color: rgba(${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b}, .65) !important;
                  }
                  .sidebar-item__link, .sidebar-item__link:hover {
                      color: ${base05} !important;
                      filter: sepia(0.1) !important;
                  }
                  .connect-section__header__icon, .connect-section__header__icon, .sidebar__footer__icon, .icon-label__icon {
                      filter: invert(1) !important;
                  }
                  .default-button {
                      color: ${base0A} !important;
                      background-color: ${base01} !important;
                  }
                  .sidebar__label, .fieldpair__description {
                      color: ${base05} !important;
                  }
                  .sidebar-item:not(.sidebar-item--selectable) {
                      color: ${base05} !important;
                  }
                  .sidebar {
                      background-color: ${base01} !important;
                  }
                  .card {
                      background: ${base01} !important;
                  }
                  .fieldpair {
                      border-color: ${base0C} !important;
                  }
              }

              @-moz-document url-prefix(about:performance) {
                  html, #dispatch-table {
                      background:none!Important;
                  }
                  #dispatch-thead>tr>td {
                      background-color: ${base00};
                      backdrop-filter: blur(10px);
                  }
                  td {
                      color: ${base01} !important;
                  }
                  #column-name {
                      padding-right: 60px!important;
                  }
                  #column-type {
                      padding-right: 0px!important;
                  }
                  td {
                      min-width: 10px!Important;
                      width: 20px!Important;
                  }
              }


            /* change highlighted text color in web pages (not URL bar) */
            @layer {
                ::selection {
                    background-color: ${base0D} !important;
                    color: ${base00} !important;
                }
                ::-moz-selection {
                    background-color: ${base0D} !important;
                    color: ${base00} !important;
                }
            }

          /* TODO none of this view source stuff works */
          @-moz-document url-prefix(view-source:) {

              /* *|*:root { */
              /*    background: none !important; */
              /* } */

              #viewsource {
                  color: ${base05};
              }

              pre[id]:before,
              span[id]:before {
                  width: 6ch !important;
                  color: ${base05} !important;
                  margin-left: -7ch !important;
              }
              pre {
                  padding-left: 1ch;
                  margin-left: 6ch !important;
                  border-left: 2px solid ${base01};
              }
              pre > :first-child {
                  padding-right: 1ch;
              }

              .highlight .start-tag {
               color: ${base0E} !important;
              }
              .highlight .end-tag {
               color: ${base0E} !important;
              }
              .highlight .comment {
               color: ${base04} !important;
              }
              .highlight .cdata {
               color: ${base08} !important;
              }
              .highlight .doctype {
               color: ${base0D} !important;
              }
              .highlight .pi {
               color: ${base0D} !important; 
              }
              .highlight .entity {
               color: ${base0A} !important;
              }
              .highlight .attribute-name {
               color: ${base05} !important;
              }
              .highlight .attribute-value {
               color: ${base0B} !important;
              }
              .highlight .markupdeclaration {
               color: ${base0C} !important;
              }
              .highlight .error,
              .highlight .error > :-moz-any(.start-tag, .end-tag, .comment, .cdata, .doctype,
              .pi, .entity, .attribute-name, .attribute-value) {
                  color: ${base01} !important;
                  background-color: ${base08} !important;
              }
          }


        '';

        # Custom CSS style options 
        userChrome = ''

            /* root variables to propagate through MANY UI elements */
            :root {
                --in-content-page-background: ${base00} !important;
                --in-content-page-color: ${base05} !important;

                --in-content-text-color: var(--in-content-page-color);
                --in-content-box-background-odd: ${base01};
                --in-content-box-info-background: ${base00};
                --in-content-border-color: ${base0D};
                --in-content-border-invalid: ${base08};
                --in-content-primary-button-text-color: ${base05};
                --in-content-primary-button-background: ${base0D};
                --in-content-primary-button-background-hover: ${base0B};
                --in-content-primary-button-background-active: ${base0C};
                --in-content-danger-button-background: ${base08};
                --in-content-danger-button-background-hover: ${base13};
                --in-content-danger-button-background-active: ${base12};
                --in-content-table-background: ${base01};
                --card-outline-color: ${base0B};
                --dialog-warning-text-color: ${base08};

                --in-content-box-border-color: ${base0F};
                --in-content-box-info-background: ${base00};
                --in-content-item-hover: color-mix(in srgb, var(--in-content-primary-button-background) 20%, transparent);
                --in-content-item-hover-text: var(--in-content-page-color);
                --in-content-item-selected: var(--in-content-primary-button-background);
                --in-content-item-selected-text: var(--in-content-primary-button-text-color);
                --in-content-border-invalid: ${base08};
                --in-content-border-color: ${base0F};
                --in-content-button-text-color: var(--in-content-text-color);
                --in-content-button-text-color-hover: var(--in-content-text-color);
                --in-content-button-text-color-active: var(--in-content-button-text-color-hover);
                --in-content-button-background: ${base01};
                --in-content-button-background-hover: ${base00};
                --in-content-button-background-active: color-mix(in srgb, currentColor 21%, transparent);
                --in-content-button-border-color: transparent;
                --in-content-button-border-color-hover: transparent;
                --in-content-button-border-color-active: var(--in-content-button-border-color-hover);
                --in-content-primary-button-text-color: ${base00};
                --in-content-primary-button-text-color-hover: var(--in-content-primary-button-text-color);
                --in-content-primary-button-text-color-active: var(--in-content-primary-button-text-color);
                --in-content-primary-button-background: ${base0D};
                --in-content-primary-button-background-hover: ${base16};
                --in-content-primary-button-background-active: ${base0C};
                --in-content-primary-button-border-color: transparent;
                --in-content-primary-button-border-hover: transparent;
                --in-content-primary-button-border-active: transparent;
                --in-content-danger-button-background: ${base08};
                --in-content-danger-button-background-hover: ${base12};
                --in-content-danger-button-background-active: ${base09};
                --focus-outline-color: ${base09};
                --in-content-focus-outline-color: var(--focus-outline-color);
                --in-content-table-background: ${base00};
                --in-content-table-border-color: var(--in-content-box-border-color);
                --in-content-table-header-background: var(--in-content-primary-button-background);
                --in-content-table-header-color: var(--in-content-primary-button-text-color);

            }

                            /* get rid of blinding white loading screen for tabs */
                            .browserContainer { background-color: ${base00} !important; }

          					/*------------- STATUS PANEL ------------------*/


          					/* color of url loading bar at bottom left */
          					#statuspanel-label {
          						background-color: ${base00} !important;
          						color: ${base0E} !important;
          						border-color: ${base0D} !important;
          					}

          					/* Change background color for both private and non-private windows */
          					@-moz-document url("chrome://browser/content/browser.xhtml") {
          						/* Non-private window background color */
          						#appcontent, #appcontent tabpanels, browser[type="content-primary"], browser[type="content"] > html, browser[type="content"] > html > body {
          							background-color: ${base00} !important;
          					}


          					/* Hover tooltip style, only themes some ie. refresh button*/
          					tooltip {
          						color: ${base05} !important;
          						background-color: ${base00} !important;
          						-moz-appearance: none !important;
          						border: 1px solid ${base0D};
          						border-radius: 2;
          					}	

          					/*--------------- TOOLBAR ----------------*/

          					/* Changes color of toolbar */
          					#navigator-toolbox{ --toolbar-bgcolor: ${base00} }

          					/* List all tabs dropdown button */
          					#alltabs-button { color: ${base0D} !important; }

          					/* Browser home button */
          					#home-button { color: ${base0B} !important; }

          					/* Shield icon */
          					#tracking-protection-icon-box {
          						color: ${base0C} !important;
          					}
          					#urlbar-input-container[pageproxystate="valid"] #tracking-protection-icon-box:not([hasException])[active] > #tracking-protection-icon{
          						color: ${base08} !important;
          					}

          					/* Back button coloring color */
          					#back-button:not([disabled="true"]):not([open="true"]):not(:active) .toolbarbutton-icon {
          						background-color: ${base00} !important;
          						color: ${base09} !important;
          					}

          					/* Back button coloring */
          					#forward-button{
          						color: ${base0B} !important;
          					}

          					/* Refresh button coloring */
          					#reload-button{
          						color: ${base0D} !important;
          					}

          					/* Cancel Loading button coloring */
          					#stop-button{
          						color: ${base08} !important;
          					}

          					/* Downloads button coloring */
          					#downloads-button{
          						color: ${base0E} !important;
          					}	
          					/* Downloads progress inner circle coloring */
          					#downloads-indicator-progress-inner{
          						--toolbarbutton-icon-fill-attention: ${base0B} !important;
          					}	
          					/* Downloads dropdown progress bar coloring */
                            .downloadProgress::-moz-progress-bar {
                              --download-progress-fill-color: ${base09};
                            }

          					/* example of setting image as icon https://www.reddit.com/r/FirefoxCSS/comments/cy8w4d/new_tab_button_customization/ */
          					/* New Tab Buttons */
          					/* the weirdness of these buttons https://www.reddit.com/r/FirefoxCSS/comments/12mjsk1/change_color_of_add_new_tab_button/ */
          					:is(#new-tab-button, #tabs-newtab-button) > .toolbarbutton-icon {
          						color: ${base0C} !important;
          					}
          					:is(#new-tab-button, #tabs-newtab-button):hover > .toolbarbutton-icon {
          						color: ${base0C} !important;
          					}

          					/* Hamburger Menu icon in toolbar */
          					#PanelUI-menu-button {
          						color: ${base0E} !important;
          					}
          					/* Extensions icon in toolbar */
          					#unified-extensions-button{
          						color: ${base0F} !important;
          					}
          					/* Account icon in toolbar */
          					#fxa-toolbar-menu-button{
          						color: ${base08} !important;
          					}

          					/* Disable favorite star button */
          					#star-button-box { display:none !important; }

          					/* close button */
          					#browser-window-close-button{
          						color: ${base08} !important;
          					}

          					/* Reader view icon */
          					#reader-mode-button-icon { color: ${base09} !important }
          					/* #reader-mode-button[readeractive] > .urlbar-icon { */
          					/*	color: ${base0E} !important */
          					/* } */
          					#reader-mode-button-icon[readeractive] {
          						color: ${base08} !important 
          					}


          					/*-----------------------------------------*/


          					/*----------------- TABS ------------------*/

          					/* Disable Favicons */
          					.tab-icon-image {
          						display: none !important;
          					}

          					/* Colors text and background of tab label */
          					.tabbrowser-tab .tab-label {
          						color: ${base05} !important;
          						background-color: ${base00} !important;
          					}

          					/* Text of secondary tab text (ie. "Playing") */
          					.tab-secondary-label {
          						color: ${base0D};
          					}
          					/* Secondary text when audio is muted */
          					.tab-secondary-label[muted] {
          						color: ${base08};
          					}

          					/* Colors text and background of tab label (selected)*/
          					.tabbrowser-tab[selected="true"] .tab-label {
          						color: ${base0B} !important;
          						background-color: ${base00} !important;
          						font-weight: bold !important;
          					}

          					/* Background color of tab itself (selected) */
          					.tabbrowser-tab[selected] .tab-content {
          						background-color: ${base00} !important; 
          					}

          					.tabbrowser-tab .tab-close-button {
          						color: ${base08};
          					}

          					/* Style for Magnifying glass icon in search bar */
          					#urlbar:not(.searchButton) > #urlbar-input-container > #identity-box[pageproxystate="invalid"] {
          						color: ${base0E} !important;
          					}

          					/* Style for close tab buttons */
          					.tabbrowser-tab:not([pinned]) .tab-close-button {
          						color: ${base0D} !important;
          					}
          					.tabbrowser-tab:not([pinned]):hover .tab-close-button {
          						color: ${base08} !important;
          						font-weight: bold !important;
          					}

          					/*-----------------------------------------*/


          					.findbar {
          						background-color: ${base00};
          						-moz-appearance: none !important;
          					}
          					.findbar-container {
          						background-color: ${base00};
          					}

                            /* BUGGED should change bg of find bar */
                            .browserContainer > findbar {
          						background-color: ${base00};

                            }

          					/* Search box when no results found */
          					.findbar-textbox[status="notfound"] {
          					  background-color: ${base00} !important;
          					  color: ${base08} !important;
          					}

          					/* Arrow buttons when no search entered */
          					.findbar-find-previous[disabled="true"] > .toolbarbutton-icon,
          					.findbar-find-next[disabled="true"] > .toolbarbutton-icon {
          						fill: ${base08} !important;
          					}
          					/* Arrows when results found */
          					.findbar-find-previous {
          						fill: ${base0A} !important;
          					}
          					.findbar-find-next {
          						fill: ${base0B} !important;
          					}

          					/* Close Icon */
          					findbar > .close-icon{
          						background-color: ${base00} !important;
          						pointer-events: auto;
          					}
          					.close-icon.findbar-closebutton {
          					  fill: ${base08} !important;
          					}

          					/* Color of "Phrase not Found" */
          					.findbar-find-status{
          						color: ${base08};
          					}

          					/* Replace checkboxes with buttons */
          					findbar .checkbox-check {
          						display: none !important;
          					}
          					findbar checkbox {
          						background: ${base00};
          						transition: 0.1s ease-in-out;
          						border: 1px solid ${base0D};
          						border-radius: 2;
          						padding: 2px 4px;
          						margin: -2px 4px !important;
          					}
          					findbar checkbox[checked="true"] {
          						background: ${base00};
          						color: ${base0B};
          						transition: 0.1s ease-in-out;
          					}
          					.found-matches {
          						color: ${base0B};
          					}


          					/*-----------------------------------------*/

          					/*------------- SITE SECURITY ICON --------*/

          					/* Green */
          					#identity-box[pageproxystate="valid"].verifiedDomain #identity-icon {
          						fill: ${base0B} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-box[pageproxystate="valid"].mixedActiveBlocked #identity-icon {
          						fill: ${base0B} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-box[pageproxystate="valid"].verifiedIdentity #identity-icon {
          						fill: ${base0B} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-popup[connection^="secure"] .identity-popup-security-connection {
          						fill: ${base0B} !important;
          					}

          					/* Red */
          					#identity-box[pageproxystate="valid"].notSecure #identity-icon {
          						fill: ${base08} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-box[pageproxystate="valid"].mixedActiveContent #identity-icon {
          						fill: ${base08} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-box[pageproxystate="valid"].insecureLoginForms #identity-icon {
          						fill: ${base08} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					.identity-popup-security-connection {
          						fill: ${base08};
          					}

          					/* Orange */
          					#identity-box[pageproxystate="valid"].mixedDisplayContent #identity-icon {
          						fill: ${base09} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-popup[mixedcontent~="passive-loaded"][isbroken] .identity-popup-security-connection {
          						fill: ${base09} !important;
          					}

          					/* Yellow */
          					#identity-box[pageproxystate="valid"].mixedDisplayContentLoadedActiveBlocked #identity-icon {
          						fill: ${base0A} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}
          					#identity-box[pageproxystate="valid"].certUserOverridden #identity-icon {
          						fill: ${base0A} !important;
          						fill-opacity: 1 !important;
          						transition: 100ms linear !important;
          					}

          					/*-----------------------------------------*/

          					/*------------- CONTEXT MENUS  --------*/

          					#context-back {
          						color: ${base09} !important;
          					}
          					#context-forward {
          						color: ${base0B} !important;
          					}
          					#context-reload {
          						color: ${base0D} !important;
          					}
          					#context-stop {
          						color: ${base08} !important;
          					}
          					#context-bookmarkpage {
          						color: ${base0A} !important;
          					}

          					/*-----------------------------------------*/

                              /*TODO does this do anything?*/
                              :root[hasbrowserhandlers="true"] body.dark.serif {
                                  background-color: ${base00} !important;
                                  color: ${base05} !important;
                              }
                              



          					/*-------------- TODO ----------------------*/
          					/* Change context menu separators *\
          					/* Close window button *\
          					/* Reader view button when reader is active *\


          				'';

        #search = {
        #	default = "DuckDuckGo";
        #	order = [
        #		"DuckDuckGo"
        #		"Google"
        #	];
        # Here is where I can put the config for individual engines
        #engines = {
        #	duckDuckGo = {};
        #};
        #};

        # Have to configure NUR, not sure if I want to do that
        #extensions = [
        #];
      };
    };
  };
}
