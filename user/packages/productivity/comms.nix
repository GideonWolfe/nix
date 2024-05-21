{ config, lib, pkgs, ... }:

{
	home.packages = [
		pkgs.lyrebird # voice changer
		pkgs.weechat # IRC TUI
		pkgs.element-desktop-wayland # Matrix GUI
		pkgs.signal-desktop
		#pkgs.discord
		#pkgs.betterdiscord-installer
		#pkgs.slack
		#pkgs.zoom-us

		########
		# NEWS #
		########

		# TUI and GUI RSS readers
		pkgs.newsboat
		pkgs.akregator

		# TUI Podcast client
		pkgs.castero
	];
}
