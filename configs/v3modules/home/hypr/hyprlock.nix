{ config, lib, pkgs, ... }:
with config.lib.stylix.colors; {
  # Enable hypridle
  programs.hyprlock = lib.mkForce {
    enable = true;
    settings = {
      general = {
        #disable_loading_bar = true;
        #grace = 300;
        hide_cursor = true;
        no_fade_in = false;
        lock_cmd =
          "notify-send 'lock!'"; # dbus/sysd lock command (loginctl lock-session)
        unlock_cmd = "notify-send 'unlock!'"; # same as above, but unlock
        before_sleep_cmd = "notify-send 'Zzz'"; # command ran before sleep
        after_sleep_cmd = "notify-send 'Awake!'"; # command ran after sleep
      };

      # HACK: option needs overriding
      background = lib.mkForce [{
        path = "${config.stylix.image}";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "200, 50";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b})";
        inner_color = "rgb(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b})";
        outer_color = "rgb(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b})";
        check_color = "rgb(${base0A-rgb-r}, ${base0A-rgb-g}, ${base0A-rgb-b})";
        fail_color = "rgb(${base08-rgb-r}, ${base08-rgb-g}, ${base08-rgb-b})";
        capslock_color =
          "rgb(${base09-rgb-r}, ${base09-rgb-g}, ${base09-rgb-b})";
        outline_thickness = 5;
        placeholder_text = "Blow above legal limit to unlock";
        fail_text = "get rekt";
        shadow_passes = 2;
        position = "0, 100";
        halign = "center";
        valign = "bottom";
      }];

      # Wallpaper window
      image = [{
        path = "${config.stylix.image}";
        size = 300; # lesser side if not 1:1 ratio
        rounding = -1; # negative values mean circle
        border_size = 4;
        border_color = "rgb(${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b})";
        rotate = 0; # degrees, counter-clockwise
        reload_time = -1; # seconds between reloading, 0 to reload with SIGUSR2
        position = "0, 0";
        halign = "center";
        valign = "center";
      }];

      label = [
        # Time
        {
          text = "$TIME";
          color = "rgb(${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b})";
          font_size = 95;
          font_family = "${config.stylix.fonts.serif.name}";
          position = "0, 400";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
          color = "rgb(${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b})";
          font_size = 22;
          #font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # Username
        {
          text = "   ${config.home.username}";
          color = "rgb(${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b})";
          font_size = 18;
          font_family = "${config.stylix.fonts.serif.name}";
          position = "0, 200";
          halign = "center";
          valign = "bottom";
        }

      ];
    };
  };

}
