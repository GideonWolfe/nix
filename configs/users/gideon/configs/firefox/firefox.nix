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
			DisableProfileImport = true; # Purity enforcement: Only allow nix-defined profiles
			DisableProfileRefresh = true; # Disable the Refresh Firefox button on about:support and support.mozilla.org
			DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image, because Nix is the only thing that can manage the backgroud
			EnableTrackingProtection = {
				Value= true;
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
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					"default_area" = "menupanel";
				};

				# Vimium
				"{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
					"installation_mode" = "force_installed";
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
					"default_area" = "menupanel";
				};
				# Keepa (amazon price tracker)
				"amptra@keepa.com" = {
					"installation_mode" = "force_installed";
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/keepa/latest.xpi";
					"default_area" = "menupanel";
				};
				# Dark Reader
				"addon@darkreader.org" = {
					"installation_mode" = "force_installed";
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
					"default_area" = "menupanel";
				};
				# New Tab Override
				"newtaboverride@agenedia.com" = {
					"installation_mode" = "force_installed";
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
					"default_area" = "menupanel";
				};
				# Bitwarden password manager
				"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
					"installation_mode" = "force_installed";
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
					"default_area" = "menupanel";
				};
				# Floccus bookmarks
				"floccus@handmadeideas.org" = {
					"installation_mode" = "force_installed";
					"install_url" = "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
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

					# Use neovim to view source
					"view_source.editor.external" = true;
					"view_source.editor.path" = "${pkgs.neovim}/bin/nvim";
					
					

					# Some style settings
					"browser.chrome.favicons" = false;



				};

				# TODO this is a cleaner way of structuring things,
				# plus you get the syntax highlighting in a .css file
				# only issue is since it isn't a nix file, we can't template out colors
				#userChrome = builtins.readFile ./userChrome.css;

				userContent = ''


				/* change background of new tab page */
				@-moz-document url("about:newtab"),
				url("about:home")
				{
					:root[lwt-newtab-brighttext] {
						--newtab-background-color: ${base00} !important;
					}
				}

				'';

				# Custom CSS style options 
				userChrome = ''

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

					/* Disable favorite star button */
					#star-button-box { display:none !important; }

					/* Reader view icon */
					#reader-mode-button-icon { color: ${base09} !important }
					#reader-mode-button[readeractive] > .urlbar-icon {
						color: ${base0E} !important 
					}


					/*-----------------------------------------*/

					/* */

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

					/* TODO Star doesn't work?*/
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
					#context-star {
						color: ${base0A} !important;
					}

					/*-----------------------------------------*/

					/* TODO this should style reader? idk if the reader pages start with about:reader*/
					@-moz-document url-prefix("about:reader") {
					  body.dark {
					    color: ${base05} !important;
					    background-color: ${base00} !important;
					  }
					  body.light {
					    color: ${base00} !important;
					    background-color: ${base05}!important;
					  }
					  body.sepia {
					    color: ${base0D} !important;
					    background-color: ${base00} !important;
					  }

					  body.serif {
					    font-family: serif !important;
					  }
					  body.sans-serif {
					    font-family: sans-serif !important;
					  }
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
