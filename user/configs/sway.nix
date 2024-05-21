{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures = {
			gtk = true;
		};
		config = rec {

			# Use Windows key for mod
			modifier = "Mod4";
			# Use kitty as default terminal
			terminal = "kitty"; 

			fonts = {
				names = [config.stylix.fonts.monospace.name];
				#style = "Regular";
				size = config.stylix.fonts.sizes.desktop + 0.0;
			};

			# Configure outputs
			output = {
				# For VM
				Virtual-1 = {
					mode = "1920x1080@60.000Hz";
				};
			};

			gaps = {
				vertical = 4;
				top = 4;
				bottom = 4;
				inner = 4;
				outer = 4;
				left = 4;
				right = 4;
				smartGaps = false;
				smartBorders = "off"; #off on or no_gaps
			};

			# Startup Commands
			startup = [
				# Launch Notification client on start
				{command = "mako";}
				# Apply colorscheme
				#{command = "wal -R";}
				# Launch Waybar
				{command = "waybar";}
			];
			
			menu = "wofi --show run";

			# if you move to one ws, tap the same number to return to last ws
			workspaceAutoBackAndForth = true;

			# Set to empty since we use waybar
			bars = [];

			keybindings = 
			let
				modifier = config.wayland.windowManager.sway.config.modifier;
			in lib.mkOptionDefault {
				"${modifier}+Shift+q" = "kill";
				"${modifier}+Shift+x" = "exec swaylock";
				"${modifier}+Shift+f" = "fullscreen toggle";
				"${modifier}+Shift+s" = "layout stacking";
				"${modifier}+Shift+w" = "layout tabbed";
				"${modifier}+Shift+e" = "layout toggle split";
				"${modifier}+Shift+space" = "floating toggle";
				"${modifier}+e" = "exec wofi-emoji";
			};

		};
	};

}
