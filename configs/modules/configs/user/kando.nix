{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

{

  # Defines the Kando Menus
  xdg.configFile.kando-menus = {
    enable = true;
    target = "kando/test.json";
    text = builtins.toJSON {
      menus = [{
        shortcut = "Control+Space";
        shortcutID = "desktop-menu";
        centered = false;
        root = {
          type = "submenu";
          name = "Desktop Menu";
          icon = "hive";
          iconTheme = "material-symbols-rounded";
          children = [
            {
              type = "submenu";
              name = "Web Links";
              icon = "public";
              iconTheme = "material-symbols-rounded";
              children = [
                {
                  type = "uri";
                  data = { uri = "https://www.google.com"; };
                  name = "Google";
                  icon = "google";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://github.com/kando-menu/kando"; };
                  name = "Kando on GitHub";
                  icon = "github";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://ko-fi.com/schneegans"; };
                  name = "Kando on Ko-fi";
                  icon = "kofi";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://www.youtube.com/@simonschneegans"; };
                  name = "Kando on YouTube";
                  icon = "youtube";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://discord.gg/hZwbVSDkhy"; };
                  name = "Kando on Discord";
                  icon = "discord";
                  iconTheme = "simple-icons";
                }
              ];
            }
            {
              type = "submenu";
              data = { };
              name = "Screenshot";
              icon = "photo_camera";
              iconTheme = "material-symbols-rounded";
              children = [
                {
                  type = "command";
                  data = {
                    command = "hyprshot -m region --raw | swappy -f -";
                    delayed = false;
                  };
                  name = "Region";
                  icon = "screenshot_region";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "hyprshot -m window --raw | swappy -f -";
                    delayed = false;
                  };
                  name = "Window";
                  icon = "select_window_2";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "hyprshot -m output --raw | swappy -f -";
                    delayed = false;
                  };
                  name = "Display";
                  icon = "screenshot_monitor";
                  iconTheme = "material-symbols-rounded";
                }
              ];
            }
            {
              type = "submenu";
              name = "Audio";
              icon = "play_circle";
              iconTheme = "material-symbols-rounded";
              children = [
                {
                  type = "hotkey";
                  data = {
                    hotkey = "MediaTrackNext";
                    delayed = false;
                  };
                  name = "Next Track";
                  icon = "skip_next";
                  iconTheme = "material-symbols-rounded";
                  angle = 90;
                }
                {
                  type = "hotkey";
                  data = {
                    hotkey = "MediaPlayPause";
                    delayed = false;
                  };
                  name = "Play / Pause";
                  icon = "play_pause";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "hotkey";
                  data = {
                    hotkey = "AudioVolumeMute";
                    delayed = false;
                  };
                  name = "Mute";
                  icon = "music_off";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "hotkey";
                  data = {
                    hotkey = "MediaTrackPrevious";
                    delayed = false;
                  };
                  name = "Previous Track";
                  icon = "skip_previous";
                  iconTheme = "material-symbols-rounded";
                  angle = 270;
                }
              ];
            }
          ];
        };
      }];
      templates = [ ];
    };

  };

  xdg.configFile.kando-config = {
    enable = true;
    target = "kando/test1.json";
    text = builtins.toJSON {
      menuTheme = "neon-lights";
      darkMenuTheme = "default";
      menuThemeColors = {
        neon-lights = {
          glow-color =
            "rgba(${base0E-rgb-r}, ${base0E-rgb-g}, ${base0E-rgb-b}, 1)";
          connector-color =
            "rgba(${base0D-rgb-r}, ${base0D-rgb-g}, ${base0D-rgb-b}, 0.75)";
        };
      };
      darkMenuThemeColors = { };
      enableDarkModeForMenuThemes = false;
      sidebarVisible = false;
      enableVersionCheck = true;
      zoomFactor = 1;
    };
  };
}
