{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    wget
    nmap
    networkmanagerapplet
    inetutils # various networking utils (ftp, traceroute, whois, etc)
    gping # graphical ping
    ip2location
    linux-wifi-hotspot # create wifi/VPN hotspots
    macchanger # manipulate and view network interface MAC addresses
    wtfis # more informative whois CLI
    speedtest-rs
    #BUG: conflicts with "speedtest" command offered by speedtest-cli
    speedtest # GTK frontend for librespeed
  ];
}
