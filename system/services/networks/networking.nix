{ config, lib, pkgs, ... }:

{
	# Enable Network Manager
	networking.networkmanager.enable = true;
	# Enable tray applet
	programs.nm-applet.enable = true;
}
