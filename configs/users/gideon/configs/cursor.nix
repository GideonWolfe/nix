{ pkgs, lib, ... }:

{
  # Specify cursor theme
  home.pointerCursor = lib.mkForce {
    # name = "phinger-cursors-light";
    # package = pkgs.phinger-cursors;
    #HACK: the capitilization may or may not be needed in the future: https://github.com/NixOS/nixpkgs/issues/321781
    # name = "catppuccin-mocha-dark-cursors";
    # https://github.com/catppuccin/cursors
    name = "Catppuccin-Mocha-Dark-Cursors"; # this creates a working symlink
    # name = "Catppuccin-Mocha-Dark"; #this creates a working symlink
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 32;
    gtk.enable = true;
  };
}
