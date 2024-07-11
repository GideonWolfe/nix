{ pkgs, lib, ... }:

{
  # Specify cursor theme
  home.pointerCursor = lib.mkForce {
    # name = "phinger-cursors-light";
    # package = pkgs.phinger-cursors;
    name = "catppuccin-mocha-dark-cursors"; # this creates a working symlink
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 32;
    gtk.enable = true;
  };
}
