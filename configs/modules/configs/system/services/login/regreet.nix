{ config, lib, pkgs, inputs, ... }:

{
  # regreet settings
  programs.regreet = {
    enable = true;
    font = {
      size = config.stylix.fonts.sizes.desktop;
      name = "${config.stylix.fonts.monospace.name}";
    };
    iconTheme = {
      name = "${config.gtk.iconTheme.name}";
      package = config.gtk.iconTheme.package;
    };
    cursorTheme = {
      name = "${config.home.pointerCursor.name}";
      package = config.home.pointerCursor.package;
    };
    settings = {
            background = {
                path = "${config.home.stylix.image}";
                fit = "Fill";
            };
            appearance = {
                greeting_msg = "You can't kill me in a way that matters";
            };
        };
  };

}
