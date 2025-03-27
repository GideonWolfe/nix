{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.firefox = {
    enable = true;

    # allow vdhcoapp to run in FF without setup step
    nativeMessagingHosts = [ pkgs.vdhcoapp ];

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
      #
      # How different mimetypes and file extensions are handled
      Handlers = {
        mimeTypes = {
          "application/msword" = {
            "action" = "useSystemDefault";
            "ask" = false;
          };
          "magnet" = {
            "action" = "useSystemDefault";
            "ask" = false;
          };
        };
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
        # Hoarder
        "addon@hoarder.app" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/hoarder-app/latest.xpi";
          "default_area" = "menupanel";
        };
        # SponsorBlock
        "sponsorBlocker@ajay.app" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          "default_area" = "menupanel";
        };
        # Reddit Enhancement Suite
        "jid1-xUfzOsOFlzSOXg@jetpack" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
          "default_area" = "menupanel";
        };
        # ViolentMonkey
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
          "default_area" = "menupanel";
        };
        # Video DownloadHelper
        # requires "vdhcoapp" companion app
        "{b9db16a4-6edc-47ec-a1f4-b86292ed211d}" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/video-downloadhelper/latest.xpi";
          "default_area" = "menupanel";
        };
        # I still don't care about cookies! autodenies/accepts EU cookie notifs
        "idcac-pub@guus.ninja" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
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

          # Enable Autoscroll
          "general.autoScroll" = true;

          # Enable Scrolling on tabs to switch
          "toolkit.tabbox.switchByScrolling" = true;

          # Change browser homepage
          "browser.startup.homepage" = "http://localhost:9876";

          # Always restore session
          "browser.startup.page" = 3;

          # Enable userChrome.css styling
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Enable stylix fonts 
          "font.name.serif.x-western" = "${config.stylix.fonts.serif.name}";

          # The background of pages/text that don't declare one (such as skeleton HTML sites)
          "browser.display.background_color" = "${base00}";
          "browser.display.foreground_color" = "${base05}";
          "browser.display.use_focus_colors" = true;
          "browser.display.focus_background_color" = "${base01}";
          "browser.display.focus_text_color" = "${base04}";

          #TODO: test!! disables documents from setting their own colors
          "browser.display.use_document_colors" = false;
          "browser.display.use_document_fonts" = 1;

          # Selects "light" theme so websites don't automatically use dark mode
          # this works better for DarkReader
          "layout.css.prefers-color-scheme.content-override" = 1;

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
          "view_source.editor.path" = "${pkgs.alacritty}/bin/alacritty";
          "view_source.editor.args" = "--command nvim";

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

          # Automatically install declared plugins
          #BUG: added on discord advice, doesn't seem to work
          "extensions.autoDisableScopes" = 0;

          # turn of google safebrowsing (it literally sends a sha sum of everything you download to google)
          "browser.safebrowsing.downloads.remote.block_dangerous" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" =
            false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.downloads.remote.url" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;

        };

        # TODO this is a cleaner way of structuring things,
        # plus you get the syntax highlighting in a .css file
        # only issue is since it isn't a nix file, we can't template out colors
        #userChrome = builtins.readFile ./userChrome.css;

        userContent = ''
          /*css*/
                       
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
                               --tab-line-selected-color: ${base0D} !important;
                               --tab-line-hover-color: ${base0E} !important;
                               /* tweaks to "firefox view" page */
                              --fxview-background-color: ${base00} !important;
                              --fxview-background-color-secondary: ${base01} !important;
                              --fxview-primary-action-background: ${base0D} !important;
                              --fxview-border: ${base0F} !important;
                              --page-nav-button-text-color: ${base0A} !important;
                              --button-text-color: ${base05} !important;

                               --theme-selection-background: ${base09} !important;

                               /* tab bar on API response page*/
                               --theme-tab-toolbar-background: ${base01} !important;

                               /* outline around search bars n stuff*/
                               --theme-focus-outline-color: ${base0D} !important;
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
                               border-color: ${base01} !important;
                       }
                       /* x symbol in input bars */
                       .search-container {
                               color: ${base08} !important;
                       }


                       /* API response pages */
                       .panelContent {
                         background: ${base01} !important;
                       }
                       .treeTable .treeRow.selected :where(:not(.objectBox-jsonml)), .treeTable .treeRow.selected .treeLabelCell::after {
                         color: ${base00} !important;
                       }
                       .objectBox-textNode, .objectBox-string, .objectBox-symbol {
                         color: ${base0E} !important;
                       }
                       .treeTable .treeRow.selected :not(input, textarea)::selection {
                         color: ${base00} !important;
                         background-color: ${base0D} !important;
                       }
                       .toolbar .btn {
                         color: ${base00} !important;
                         background: ${base0D} !important;
                       }
                       .toolbar .btn:hover {
                         color: ${base00} !important;
                         background: ${base0B} !important;
                       }
                       .toolbar {
                         background: ${base01} !important;
                       }

                       /* text color of visited links */
                       /* works for some, darkdreader seems to override others */
                       .a:visited:not(.no-visited) {
                         color: ${base0E} !important;
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
                               
                               --card-outline-color: ${base09} !important;

                               --theme-icon-color: ${base0B} !important;
                               --theme-icon-dimmed-color: ${base04} !important;
                               --theme-icon-checked-color: ${base0D} !important;
                               --theme-icon-warning-color: ${base09} !important;

                               --table-row-background-color-alternate: ${base01} !important;

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

                       /* specific styling for support page */
                       @-moz-document url-prefix("about:support") {
                           :root {
                               --in-content-table-background: ${base01} !important;
                           }
                           table {
                               background-color: ${base01} !important;
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

                     /* View source syntax highlighting */
                     @media (-moz-bool-pref: "view_source.syntax_highlight") {
                       .start-tag,
                       .end-tag {
                         color: ${base0E} !important;
                         font-weight: bold;
                       }
                       .comment {
                         color: ${base04} !important;
                         /* font-style: italic; */
                       }
                       .cdata {
                         color: ${base08} !important;
                       }
                       .doctype,
                       .markupdeclaration {
                         color: ${base0D} !important;
                         font-style: italic;
                       }
                       .pi {
                         color: ${base0E} !important;
                         font-style: italic;
                       }
                       .entity {
                         color: ${base08} !important;
                       }
                       .text {
                         font-weight: normal;
                         color: ${base05} !important;
                       }
                       .attribute-name {
                         font-weight: bold;
                       }
                       .attribute-value {
                         color: ${base08} !important;
                         font-weight: normal;
                       }
                       .error {
                         color: ${base00} !important;
                         font-weight: bold;
                         background-color: ${base08} !important;
                         text-decoration: underline wavy ${base08} 0.5px !important;
                       }
                     }

                   /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/content/auto_devtools_theme.css */
                   /* Make devtools use dark theme if your OS is in dark mode. Set devtools to Light-theme for this style to work */
                   @-moz-document url("about:devtools-toolbox"), url-prefix("chrome://devtools/content/"){
                     @media(prefers-color-scheme: dark){
                       :root {
                         --badge-active-background-color: ${base0D} !important;
                         --badge-active-border-color: ${base08} !important;
                         --badge-background-color: ${base00} !important;
                         --badge-border-color: ${base0A} !important;
                         --badge-color: ${base05} !important;
                         --badge-hover-background-color: ${base01} !important;
                         --badge-interactive-background-color: ${base01} !important;
                         --badge-interactive-color: ${base0A} !important;
                         --badge-scrollable-color: ${base0E} !important;
                         --badge-scrollable-background-color: transparent !important;
                         
                         --tab-line-hover-color: ${base08} !important;
                         --toggle-thumb-color: var(--grey-40) !important;
                         --toggle-track-color: var(--grey-60) !important;
                         --searchbox-no-match-background-color: ${base00} !important;
                         --searchbox-no-match-stroke-color: ${base08} !important;
                         
                         --bezier-diagonal-color: ${base05} !important;
                         
                         --bezier-grid-color: rgba(0, 0, 0, 0.2) !important;
                         --theme-tooltip-color: var(--theme-text-color-strong) !important;
                         --theme-tooltip-background: ${base00} !important;
                         --theme-tooltip-shadow: rgba(25, 25, 25, 0.76) !important;
                         --theme-tooltip-icon-dimmed-color: rgb(255, 255, 255) !important;
                         --theme-arrowpanel-background: var(--theme-popup-background) !important;
                         --theme-arrowpanel-color: var(--theme-popup-color) !important;
                         --theme-arrowpanel-border-color: var(--theme-popup-border-color) !important;
                         --theme-arrowpanel-separator: ${base0F} !important;
                         --theme-arrowpanel-dimmed: var(--theme-popup-dimmed) !important;
                         --theme-arrowpanel-dimmed-further: rgba(249,249,250,.15) !important;
                         --theme-arrowpanel-disabled-color: rgba(249,249,250,.5) !important;
                         
                         --theme-body-background: ${base00} !important;
                         --theme-body-emphasized-background: ${base01} !important;
                         --theme-sidebar-background: ${base00} !important;

                         /* Toolbar */
                         --theme-tab-toolbar-background: ${base01} !important;
                         --theme-toolbar-background: ${base00} !important;
                         --theme-toolbar-color: ${base05} !important;
                         --theme-toolbar-selected-color: ${base05} !important;
                         --theme-toolbar-highlighted-color: ${base0B} !important;
                         --theme-toolbar-background-hover: ${base01} !important;
                         --theme-toolbar-background-alt: ${base01} !important;
                         --theme-toolbar-hover: ${base01} !important;
                         --theme-toolbar-hover-active: ${base02} !important;
                         --theme-toolbar-separator: ${base0E} !important;


                         /* Toolbar buttons */
                         --toolbarbutton-background: ${base00} !important;
                         --toolbarbutton-hover-background: ${base01} !important;
                         --toolbarbutton-focus-background: ${base01} !important;
                         --toolbarbutton-focus-color: ${base0B} !important;
                         --toolbarbutton-checked-background: ${base0A} !important;
                         --toolbarbutton-checked-focus-background: ${base0B} !important;
                         --toolbarbutton-checked-color: ${base05} !important;

                         /* Buttons */
                         --theme-button-background: ${base00} !important;
                         --theme-button-active-background: ${base01} !important;

                         /* Accordion headers */
                         --theme-accordion-header-background: ${base00} !important;
                         --theme-accordion-header-hover: ${base01} !important;

                         /* Selection */
                         --theme-selection-background: ${base09} !important;
                         --theme-selection-background-hover: ${base01} !important;
                         --theme-selection-focus-background: ${base01} !important;
                         --theme-selection-color: ${base00} !important;

                         /* Border color that splits the toolbars/panels/headers. */
                         --theme-splitter-color: ${base04} !important;
                         --theme-emphasized-splitter-color: ${base0A} !important;
                         --theme-emphasized-splitter-color-hover: ${base09} !important;

                         /* Icon colors */
                         --theme-icon-color: ${base0B} !important;
                         --theme-icon-dimmed-color: ${base04} !important;
                         --theme-icon-checked-color: ${base0D} !important;
                         --theme-icon-error-color: ${base08} !important;
                         --theme-icon-warning-color: ${base0A} !important;

                         /* Text color */
                         --theme-comment: ${base04} !important;
                         --theme-body-color: ${base05} !important;
                         --theme-text-color-alt: var(${base04}) !important;
                         --theme-text-color-inactive: ${base04} !important;
                         --theme-text-color-strong: ${base0E} !important;
                         --theme-stack-trace-text: ${base08} !important;
                         --theme-internal-link-color: ${base0D} !important;

                         --theme-highlight-green: ${base0B} !important;
                         --theme-highlight-blue: ${base0D} !important;
                         --theme-highlight-purple: ${base0E} !important;
                         --theme-highlight-red: ${base08} !important;
                         --theme-highlight-yellow: ${base0A} !important;

                         /* These theme-highlight color variables have not been photonized. */
                         --theme-highlight-bluegrey: ${base0D} !important;
                         --theme-highlight-lightorange: ${base09} !important;
                         --theme-highlight-orange: ${base09} !important;
                         --theme-highlight-pink: ${base0E} !important;
                         --theme-highlight-gray: ${base05} !important;

                         /* For accessibility purposes we want to enhance the focus styling. This
                          * should improve keyboard navigation usability. */
                         --theme-focus-outline-color: ${base04} !important;

                         /* Colors used in Graphs, like performance tools. Mostly similar to some "highlight-*" colors. */
                         --theme-graphs-green: ${base0B} !important;
                         --theme-graphs-blue: ${base0D} !important;
                         --theme-graphs-bluegrey: ${base0D} !important;
                         --theme-graphs-purple: ${base0E} !important;
                         --theme-graphs-yellow: ${base0A} !important;
                         --theme-graphs-orange: ${base09} !important;
                         --theme-graphs-red: ${base08} !important;
                         --theme-graphs-grey: ${base04} !important;
                         --theme-graphs-full-red: ${base08} !important;
                         --theme-graphs-full-blue: ${base0D} !important;

                         /* Common popup styles(used by HTMLTooltip and autocomplete) */
                         --theme-popup-background: ${base01} !important;
                         --theme-popup-color: ${base0A} !important;
                         --theme-popup-border-color: ${base0A} !important;
                         --theme-popup-dimmed: rgba(249, 249, 250, 0.1) !important;

                         /* Styling for devtool buttons */
                         --theme-toolbarbutton-background: ${base01} !important;
                         --theme-toolbarbutton-color: ${base0A} !important;
                         --theme-toolbarbutton-hover-background: ${base00} !important;
                         --theme-toolbarbutton-checked-background: ${base0E} !important;
                         --theme-toolbarbutton-checked-color: ${base00} !important;
                         --theme-toolbarbutton-checked-hover-background: ${base08} !important;
                         --theme-toolbarbutton-checked-hover-color: ${base00} !important;
                         --theme-toolbarbutton-active-background: ${base00} !important;
                         --theme-toolbarbutton-active-color: ${base0B} !important;

                         --theme-toolbar-selected-color: ${base09} !important;
                         --theme-toolbar-hover-color: ${base0E} !important;

                         /* Used for select elements */
                         --theme-select-background: ${base01} !important;
                         --theme-select-color: ${base05} !important;
                         --theme-select-hover-border-color: ${base03} !important;

                         /* Warning colors */
                         --theme-warning-background: ${base00} !important;
                         --theme-warning-border: ${base08} !important;
                         --theme-warning-color: ${base08} !important;

                         /* Flashing colors used to highlight updates */
                         --theme-contrast-background: #4f4b1f !important; /* = Yellow 50-a20 on body background */
                         --theme-contrast-background-alpha: rgba(255, 233, 0, 0.15) !important; /* Yellow 50-a15 */
                         --theme-contrast-color: ${base05} !important;
                         --theme-contrast-border: ${base0A} !important;
                         
                         --markup-hidden-attr-name-color: ${base04} !important;
                         --markup-hidden-attr-value-color: ${base05} !important;
                         --markup-hidden-punctuation-color: ${base04} !important;
                         --markup-hidden-tag-color: ${base04} !important;
                         --markup-outline: var(--theme-selection-background) !important;
                         --markup-drag-line: ${base04} !important;
                         --markup-drop-line: ${base0D} !important;
                         --markup-overflow-causing-background-color: rgba(148, 0, 255, 0.38) !important;
                         
                         --console-input-background: var(--theme-tab-toolbar-background) !important;
                         --console-message-background: var(--theme-body-background) !important;
                         --console-message-border: var(--theme-splitter-color) !important;
                         --console-message-color: ${base05} !important;
                         --console-error-background: ${base00} !important;
                         --console-error-border: var(--theme-splitter-color) !important;
                         --console-error-color: ${base08} !important;
                         --console-warning-border: var(--theme-splitter-color) !important;
                         --console-warning-color: ${base09} !important;
                         --console-navigation-color: var(--theme-highlight-blue) !important;
                         --console-navigation-border: ${base0D} !important;
                         --console-indent-border-color: var(--theme-highlight-blue) !important;
                         --console-repeat-bubble-background: ${base0D} !important;
                         --error-color: ${base08} !important;
                         --console-output-color: ${base05} !important;
                         
                         --scrollbar-color: ${base04} var(--theme-splitter-color) !important;

                         --tab-line-selected-color: ${base0D} !important;

                         /* graphs on networking tab */
                         --timing-wait-color: ${base0D} !important;
                         --timing-send-color: ${base0C} !important;
                         --timing-receive-color: ${base0B} !important;
                         --timing-connect-color: ${base09} !important;
                         --timing-ssl-color: ${base0A} !important;
                         --timing-dns-color: ${base0E} !important;
                         --timing-server-color-1: ${base0E} !important;
                         --timing-server-color-2: ${base0F} !important;
                         --timing-server-color-3: ${base0C} !important;
                         --timing-server-color-total: ${base09} !important;

                         /* rule header for styles */
                         --rule-header-background-color: ${base01} !important;
                       }
                     }


                     /* Toolbox */
                     .devtools-tabbar {
                       color: ${base05} !important;
                       background-color: ${base01} !important;
                     }
                     .devtools-tab {
                       background-color: ${base00} !important;
                       color: ${base05} !important;
                     }
                     .devtools-tab:hover {
                       background-color: ${base01} !important;
                       color: ${base0E} !important;
                     }
                     .devtools-tab:active {
                       background-color: ${base01} !important;
                       color: ${base0D} !important;
                     }
                     .devtools-tab.selected {
                       color: ${base09} !important;
                     }

                     /* toolbox error button */
                     .toolbox-error::before {
                       fill: ${base08} !important;
                     }

                     /* Notification box (above toolbox) */
                     .notificationbox .notification {
                       color: ${base05} !important;
                       background-color: ${base01} !important;
                     }

                     /* badge for XHR requests */
                     .webconsole-app .message.network .xhr {
                         background-color: ${base09} !important;
                         color: ${base00} !important;
                     }

                     /* request and response error header */
                     .theme-dark .network-monitor .request-error-header, .theme-dark .network-monitor .response-error-header {
                       background-color: ${base08} !important;
                       color: ${base00} !important;
                     }

                     /* "Start recording" button on performance page */
                     .perf-photon-button-primary {
                       background-color: ${base0D} !important;
                       color: ${base00} !important;
                     }
                     .perf-photon-button-primary:hover:not([disabled]) {
                       background-color: ${base0B} !important;
                     }
                     .perf-photon-button-primary:hover:active:not([disabled]) {
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
                --card-outline-color: ${base0B} !important;
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
                --in-content-primary-button-background: ${base0D} !important;
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

                --background-color-box: ${base00} !important;

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

          					/* webcam enabled recording coloring */
                            #webrtc-sharing-icon[sharing]:not([paused]) {
                                fill: ${base08} !important;
                            }

          					/* settings button for when permissions are used */
                            #permissions-granted-icon {
          						color: ${base09} !important;
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

                            #reader-mode-button[readeractive] > .urlbar-icon {
                              fill: ${base08} !important;
                            }


                            #urlbar-zoom-button {
                              background-color: ${base00}!important;
                              color: ${base0A} !important;
                            }
                            #urlbar-zoom-button:hover {
                              background-color: ${base0A}!important;
                              color: ${base00} !important;
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

                            .tabbrowser-tab[pinned] {
                                width: 100px;
                                border: 1px solid ${base0E} !important;
          						font-style: italic !important;
                            }
                            /* .tab-background[pinned] { */
                            /*     border: 1px solid ${base0E} !important; */
                            /* } */


                            /* Speaker icon on tab playing media  */
                            /* TODO not sure what activemedia-blocked does, may want to style differently  */
                            .tab-icon-overlay {
                              &:not([crashed]) {
                                &:is([soundplaying], [activemedia-blocked]) {
                                  background-color: ${base0B} !important;
                                  fill: ${base00} !important;
                                }
                              }
                            }
                            /* Speaker icon on tab playing media hovering */
                            .tab-icon-overlay {
                              &:not([crashed]) {
                                &:is([soundplaying], [activemedia-blocked]):hover {
                                  background-color: ${base09} !important;
                                  fill: ${base00} !important;
                                }
                              }
                            }
                            /* Speaker icon on tab muted media  */
                            .tab-icon-overlay {
                              &:not([crashed]) {
                                &:is([muted], [activemedia-blocked]) {
                                  background-color: ${base08} !important;
                                  fill: ${base00} !important;
                                }
                              }
                            }
                            /* Speaker icon on tab muted media hovering */
                            .tab-icon-overlay {
                              &:not([crashed]) {
                                &:is([muted], [activemedia-blocked]):hover {
                                  background-color: ${base0D} !important;
                                  fill: ${base00} !important;
                                }
                              }
                            }

          					/*-----------------------------------------*/


          					.findbar {
          						background-color: ${base00};
          						-moz-appearance: none !important;
          					}
          					.findbar-container {
          						background-color: ${base00};
          					}

                            /* bg/border of find bar */
                            .browserContainer > findbar {
          						background-color: ${base00} !important;
          						border-top-color: ${base0E} !important;

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
