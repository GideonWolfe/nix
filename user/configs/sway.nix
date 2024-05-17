{ pkgs, lib, ... }:

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
			 # Startup Commands
			startup = [
				# Launch Notification client on start
				{command = "mako";}
				# Apply colorscheme
				{command = "wal -R";}
			];
		};
	};

}
