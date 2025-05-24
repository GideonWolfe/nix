{ config, lib, pkgs, ... }:

{
	# Enable CUPS daemon
	services.printing.enable = true;
	# CUPS Settings
	#services.printing.settings = {
	#};
}
