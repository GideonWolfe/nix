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
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b})";
        inner_color = "rgb(${base00-rgb-r}, ${base00-rgb-g}, ${base00-rgb-b})";
        outer_color = "rgb(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b})";
        outline_thickness = 5;
        placeholder_text = "Blow above legal limit to unlock:";
        shadow_passes = 2;
      }];

      label = [
        {
          text = "$TIME";
          color = "rgb(${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b})";
          font_size = 95;
          font_family = "${config.stylix.fonts.serif.name}";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
          color = "rgb(${base0B-rgb-r}, ${base0B-rgb-g}, ${base0B-rgb-b})";
          font_size = 22;
          #font_family = "JetBrains Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";

        }
      ];
    };
  };

}
