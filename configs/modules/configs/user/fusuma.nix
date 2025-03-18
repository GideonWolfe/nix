{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  services.fusuma = {
    enable = true;
    settings = {
      threshold = { swipe = 0.1; };
      interval = { swipe = 0.7; };
      swipe = {
        "3" = {
          left = {
            # Hyprland: Switch to left workspace
            command = "hyprctl dispatch workspace -1";
          };
        };
      };

    };
  };
}
