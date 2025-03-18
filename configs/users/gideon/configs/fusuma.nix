{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  services.fusuma = {
    enable = true;
    settings = {
      threshold = {
        #swipe = 0.5;
        pinch = 0.1;
      };
      interval = {
        #swipe = 0.5;
        pinch = 0.4;
      };
      swipe = {
        "3" = {
          left = {
            # Hyprland: Switch to left workspace
            command =
              "/run/current-system/sw/bin/hyprctl dispatch workspace -1";
          };
          right = {
            # Hyprland: Switch to right workspace
            command =
              "/run/current-system/sw/bin/hyprctl dispatch workspace +1";
          };
        };
      };
      pinch = {
        "2" = {
          "in" = {
            command =
              "/run/current-system/sw/bin/hyprctl dispatch fullscreenstate 0 0";
          };
          "out" = {
            command =
              "/run/current-system/sw/bin/hyprctl dispatch fullscreenstate 2 0";
          };
        };
      };
      hold = {
        "4" = {
          command =
            "${lib.getExe pkgs.kando} --menu desktop-menu";
        };
      };

    };
  };
}
