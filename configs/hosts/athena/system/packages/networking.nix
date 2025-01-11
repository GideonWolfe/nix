{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		wget
		nmap
		networkmanager
		networkmanagerapplet
		bluez
		blueman
		inetutils # various networking utils (ftp, traceroute, whois, etc)
		libsForQt5.kdeconnect-kde
		openssh
		gping #graphical ping
		ip2location
		#tightvnc #VNC service
        linux-wifi-hotspot # create wifi/VPN hotspots
        tcpdump
	];
}
