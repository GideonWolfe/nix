{ config, lib, pkgs, ... }:

{
  home.packages = [
    #pkgs.firefox
    pkgs.w3m
    pkgs.qutebrowser
    pkgs.miniserve # serve startpage and other apps easily
    pkgs.amfora # TUI gemini browser
  ];
}
