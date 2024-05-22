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

					general.autoScroll = true;

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

				# Custom CSS style options 
				userChrome = ''

					/*--------------- TOOLBAR ----------------*/

					/* Changes color of toolbar */
					#navigator-toolbox{ --toolbar-bgcolor: ${base00} }

					/* Back button coloring color */
					#back-button:not([disabled="true"]):not([open="true"]):not(:active) .toolbarbutton-icon {
						background-color: ${base00} !important;
						color: ${base09} !important;
					}

					/* Back button coloring color */
					#forward-button{
						color: ${base0B} !important;
					}

					#reload-button{
						color: ${base0D} !important;
					}

					#stop-button{
						color: ${base08} !important;
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

					/*-----------------------------------------*/

					/* */

					/*----------------- TABS ------------------*/

					/* Colors text and background of tab label */
					.tabbrowser-tab .tab-label {
						color: ${base05} !important;
						background-color: ${base00} !important;
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


					/*-----------------------------------------*/





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
