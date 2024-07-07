{ pkgs, lib, ... }:

{

	wayland.windowManager.hyprland = {
		# allow home manager to configure hyprland	
		enable = false;
	};
}
