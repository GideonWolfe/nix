{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		wget
		networkmanager
		networkmanagerapplet
		bluez
		blueman
		inetutils # various networking utils (ftp, traceroute, whois, etc)
		libsForQt5.kdeconnect-kde
		openssh
		gping #graphical ping
	];
}
