{ pkgs, lib, stylix, config, ... }:

{
  stylix.enable = true;

  stylix.polarity = "dark";

  #TODO: this isn't implemented, need to update stylix to get it
  # stylix.iconTheme = {
  #   enable = true;
  #   package = pkgs.libsForQt5.breeze-icons;
  #   dark = "breeze-dark";
  #   light = "breeze";
  # };
  #
  stylix.targets = {
    firefox = { profileNames = [ "default" ]; };
    # testing disabling bc it should be on by default
    #zathura = { enable = true; };
    # testing disabling bc it should be on by default
    #nixvim = { enable = true; };
    #hyprland = { enable = true; };
    # It doesn't really use enough colors! I set them manually
    spicetify = { enable = false; };
  };
}
