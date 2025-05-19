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
    # It doesn't really use enough colors! I set them manually
    spicetify = { enable = false; };
    # TODO: enable on 25.05
    # default is false
        #qt.enable = true;
  };
}
