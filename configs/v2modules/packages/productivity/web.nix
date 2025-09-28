{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    #pkgs.firefox
    chromium
    w3m
    qutebrowser
    miniserve # serve startpage and other apps easily
    amfora # TUI gemini browser
    tor-browser
  ];
}
