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

		};
	};

}
