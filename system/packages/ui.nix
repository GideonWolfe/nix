{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [

		# XDG portals
		xdg-desktop-portal
		xdg-desktop-portal-wlr
		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gnome
		xdg-desktop-portal-gtk
		lxqt.xdg-desktop-portal-lxqt
		xdg-desktop-portal-kde

		# Window manager
		hyprland
		sway

		# Bar
		waybar
	];
}
