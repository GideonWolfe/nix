{ pkgs, lib, config, ... }:

with config.lib.stylix.colors;

{

  # Defines the Kando Menus
  xdg.configFile.kando-menus = {
    enable = true;
    target = "kando/menus.json";
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
                  data = { uri = "https://searchix.alanpearce.eu/"; };
                  name = "Nix Search";
                  icon = "nixos";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://reddit.com"; };
                  name = "Reddit";
                  icon = "reddit";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://youtube.com"; };
                  name = "Youtube";
                  icon = "youtube";
                  iconTheme = "simple-icons";
                }
                {
                  type = "uri";
                  data = { uri = "https://discord.gg/hZwbVSDkhy"; };
                  name = "Dotfiles";
                  icon = "github";
                  iconTheme = "simple-icons";
                }
              ];
            }
            {
              type = "submenu";
              data = { };
              name = "Utils";
              icon = "bolt";
              iconTheme = "material-symbols-rounded";
              children = [
                {
                  type = "command";
                  data = {
                    command = "qalculate-gtk";
                    delayed = true;
                  };
                  name = "Calculator";
                  icon = "calculate";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "dialect";
                    delayed = false;
                  };
                  name = "Translator";
                  icon = "translate";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "resources";
                    delayed = false;
                  };
                  name = "Task Manager";
                  icon = "monitor_heart";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "hyprctl kill";
                    delayed = false;
                  };
                  name = "Kill app";
                  icon = "skull";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "cheese";
                    delayed = false;
                  };
                  name = "Webcam";
                  icon = "camera_video";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "hyprpicker -a";
                    delayed = true;
                  };
                  name = "Color Picker";
                  icon = "colorize";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "gnome-calendar";
                    delayed = false;
                  };
                  name = "Calendar";
                  icon = "calendar_month";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "gnome-clocks";
                    delayed = false;
                  };
                  name = "Timer";
                  icon = "timer";
                  iconTheme = "material-symbols-rounded";
                }
              ];
            }
            {
              type = "submenu";
              data = { };
              name = "Apps";
              icon = "rocket_launch";
              iconTheme = "material-symbols-rounded";
              children = [
                {
                  type = "command";
                  data = {
                    command = "firefox";
                    delayed = false;
                  };
                  name = "Firefox";
                  icon = "firefoxbrowser";
                  iconTheme = "simple-icons";
                }
                {
                  type = "submenu";
                  data = { };
                  name = "Comms";
                  icon = "headset_mic";
                  iconTheme = "material-symbols-rounded";
                  children = [
                    {
                      type = "command";
                      data = {
                        command = "flare";
                        delayed = false;
                      };
                      name = "Signal";
                      icon = "signal";
                      iconTheme = "simple-icons";
                    }
                    {
                      type = "command";
                      data = {
                        command = "thunderbird";
                        delayed = false;
                      };
                      name = "Email";
                      icon = "stacked_email";
                      iconTheme = "material-symbols-rounded";
                    }
                    {
                      type = "uri";
                      data = { uri = "https://messages.google.com"; };
                      name = "SMS";
                      icon = "sms";
                      iconTheme = "material-symbols-rounded";
                    }
                    {
                      type = "command";
                      data = {
                        command = "slack";
                        delayed = false;
                      };
                      name = "Slack";
                      icon = "slack";
                      iconTheme = "simple-icons";
                    }
                    {
                      type = "command";
                      data = {
                        command = "halloy";
                        delayed = false;
                      };
                      name = "IRC";
                      icon = "terminal";
                      iconTheme = "material-symbols-rounded";
                    }
                    {
                      type = "command";
                      data = {
                        command = "vesktop";
                        delayed = false;
                      };
                      name = "Discord";
                      icon = "discord";
                      iconTheme = "simple-icons";
                    }
                    {
                      type = "command";
                      data = {
                        command = "fractal";
                        delayed = false;
                      };
                      name = "Matrix";
                      icon = "matrix";
                      iconTheme = "simple-icons";
                    }
                  ];
                }
                {
                  type = "command";
                  data = {
                    command = "cartridges";
                    delayed = false;
                  };
                  name = "Games";
                  icon = "stadia_controller";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "GDK_BACKEND=x11 delfin";
                    delayed = false;
                  };
                  name = "Media";
                  icon = "jellyfin";
                  iconTheme = "simple-icons";
                }
                {
                  type = "command";
                  data = {
                    command = "bitwarden";
                    delayed = false;
                  };
                  name = "Passwords";
                  icon = "password";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "obsidian";
                    delayed = false;
                  };
                  name = "Obsidian";
                  icon = "obsidian";
                  iconTheme = "simple-icons";
                }
                {
                  type = "command";
                  data = {
                    command = "nautilus";
                    delayed = false;
                  };
                  name = "Files";
                  icon = "folder_copy";
                  iconTheme = "material-symbols-rounded";
                }
              ];
            }
            {
              type = "submenu";
              data = { };
              name = "Settings";
              icon = "settings";
              iconTheme = "material-symbols-rounded";
              children = [
                {
                  type = "command";
                  data = {
                    command = "pwvucontrol";
                    delayed = false;
                  };
                  name = "Audio";
                  icon = "sound_detection_loud_sound";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "nm-connection-editor";
                    delayed = true;
                  };
                  name = "Network";
                  icon = "lan";
                  iconTheme = "material-symbols-rounded";
                }
                {
                  type = "command";
                  data = {
                    command = "blueman-manager";
                    delayed = false;
                  };
                  name = "Bluetooth";
                  icon = "bluetooth";
                  iconTheme = "material-symbols-rounded";
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
    target = "kando/config.json";
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
      #INFO: fixes kando throwing error bc of symlinks
      ignoreWriteProtectedConfigFiles = true;
    };
  };
}
