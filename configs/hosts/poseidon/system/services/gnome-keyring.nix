{ config, lib, pkgs, ... }:

{
	# Enable gnome-keyring
	services.gnome.gnome-keyring.enable = true;
}
