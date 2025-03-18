{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  services.flameshot = {
    enable = true;

    settings = {
      # reference: https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
      General = {
        # colors to use for drawing on screenshots
        userColors =
          "picker, ${base01}, ${base02}, ${base0A}, ${base0B}, ${base0C}, ${base0D}, ${base0E}";
        uiColor = "${base05}";
        contrastUiColor = "${base0C}";
        drawColor = "${base0D}";

        # default path to save screenshots
        savePath = "${config.home.homeDirectory}/pictures/screenshots/";

        # disable tray icon
        disabledTrayIcon = false;
      };
    };

  };
}
