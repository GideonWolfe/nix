{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    gucharmap
    gnome-font-viewer
  ];
  fonts.packages = with pkgs; [
    # collection of patched fonts
    nerd-fonts.hack
    #noto-fonts
    # symbols and emoji (outlined)
    #symbola
    noto-fonts-monochrome-emoji
    # chinese, japanese, korean
    #noto-fonts-cjk
    #noto-fonts-cjk-sans
    #noto-fonts-cjk-serif
    # Font Awesome
    font-awesome
    font-awesome_5
  ];
}
