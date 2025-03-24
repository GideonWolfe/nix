{ config, lib, pkgs, inputs, ... }:

{
  # Enable lightdm
  services.xserver.displayManager.lightdm = {
    enable = true;
        #background = "${config.stylix.image}";

    #Slick greeter config
    greeters.slick = {
      enable = true;
      font.name = "${config.stylix.fonts.monospace.name}";
      cursorTheme.name = "${config.home.pointerCursor.name}";
      cursorTheme.package = "${config.home.pointerCursor.package}";
      cursorTheme.size = "${config.home.pointerCursor.size}";
      extraConfig = ''
        background=${config.stylix.image}
      '';
    };
  };

}
