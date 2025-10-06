{ config, lib, pkgs, ... }: {
  # Enable hypridle
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        # warning before screen lock
        {
          timeout = 240;
          on-timeout =
            "notify-send -u critical 'Screen Will Lock' 'One minute remaining'";
        }
        # will lock screen
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        # will enter hibernation
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

}
