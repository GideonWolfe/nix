{ config, lib, pkgs, ... }:

{
	# Enable Bluetooth
	hardware.bluetooth.enable = true;
	# Enable GTK based manager
	services.blueman.enable = true;
}
