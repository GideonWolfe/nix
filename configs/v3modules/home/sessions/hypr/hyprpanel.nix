{ pkgs, lib, config, osConfig, ... }:

with config.lib.stylix.colors.withHashtag;

{

  programs.hyprpanel = {
    enable = true;

    settings = {

      theme = {
        bar = {
          scaling = 75;
          dropdownGap = "2.1em";
          menus = {
            menu = {
              notifications = {
                scaling = 70;
                scrollbar = { color = "${base07}"; };
                pager = {
                  label = "${base04}";
                  button = "${base0E}";
                  background = "${base01}";
                };
                switch = {
                  puck = "${base00}";
                  disabled = "${base08}";
                  enabled = "${base0B}";
                  divider = "${base03}";
                };
                clear = "${base08}";
                border = "${base02}";
                card = "${base00}";
                background = "${base01}";
                no_notifications_label = "${base02}";
                label = "${base07}";
              };
              power = {
                scaling = 70;
                buttons = {
                  sleep = {
                    icon = "${base01}";
                    text = "${base0C}";
                    icon_background = "${base0C}";
                    background = "${base00}";
                  };
                  logout = {
                    icon = "${base01}";
                    text = "${base0B}";
                    icon_background = "${base0B}";
                    background = "${base00}";
                  };
                  restart = {
                    icon = "${base01}";
                    text = "${base09}";
                    icon_background = "${base09}";
                    background = "${base00}";
                  };
                  shutdown = {
                    icon = "${base01}";
                    text = "${base08}";
                    icon_background = "${base08}";
                    background = "${base00}";
                  };
                };
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
              };
              dashboard = {
                scaling = 70;
                confirmation_scaling = 70;
                monitors = {
                  disk = {
                    label = "${base0D}";
                    bar = "${base0D}";
                    icon = "${base0D}";
                  };
                  gpu = {
                    label = "${base0B}";
                    bar = "${base0B}";
                    icon = "${base0B}";
                  };
                  ram = {
                    label = "${base0A}";
                    bar = "${base0A}";
                    icon = "${base0A}";
                  };
                  cpu = {
                    label = "${base08}";
                    bar = "${base08}";
                    icon = "${base08}";
                  };
                  bar_background = "${base03}";
                };
                directories = {
                  right = {
                    bottom = { color = "${base08}"; };
                    middle = { color = "${base0E}"; };
                    top = { color = "${base0C}"; };
                  };
                  left = {
                    bottom = { color = "${base0B}"; };
                    middle = { color = "${base0A}"; };
                    top = { color = "${base09}"; };
                  };
                };
                controls = {
                  input = {
                    text = "${base01}";
                    background = "${base09}";
                  };
                  volume = {
                    text = "${base01}";
                    background = "${base0B}";
                  };
                  notifications = {
                    text = "${base01}";
                    background = "${base0A}";
                  };
                  bluetooth = {
                    text = "${base01}";
                    background = "${base0C}";
                  };
                  wifi = {
                    text = "${base01}";
                    background = "${base0E}";
                  };
                  disabled = "${base04}";
                };
                shortcuts = {
                  recording = "${base0B}";
                  text = "${base01}";
                  background = "${base0D}";
                };
                powermenu = {
                  confirmation = {
                    button_text = "${base01}";
                    deny = "${base08}";
                    confirm = "${base0B}";
                    body = "${base05}";
                    label = "${base07}";
                    border = "${base02}";
                    background = "${base01}";
                    card = "${base00}";
                  };
                  sleep = "${base0C}";
                  logout = "${base0B}";
                  restart = "${base09}";
                  shutdown = "${base08}";
                };
                profile = { name = "${base06}"; };
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
                card = { color = "${base00}"; };
              };
              clock = {
                scaling = 70;
                weather = {
                  hourly = {
                    temperature = "${base06}";
                    icon = "${base06}";
                    time = "${base06}";
                  };
                  thermometer = {
                    extremelycold = "${base0C}";
                    cold = "${base0D}";
                    moderate = "${base07}";
                    hot = "${base09}";
                    extremelyhot = "${base08}";
                  };
                  stats = "${base06}";
                  status = "${base0C}";
                  temperature = "${base05}";
                  icon = "${base06}";
                };
                calendar = {
                  contextdays = "${base04}";
                  days = "${base05}";
                  currentday = "${base06}";
                  paginator = "${base0F}";
                  weekdays = "${base06}";
                  yearmonth = "${base0C}";
                };
                time = {
                  timeperiod = "${base0C}";
                  time = "${base06}";
                };
                text = "${base05}";
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
                card = { color = "${base00}"; };
              };
              battery = {
                scaling = 70;
                slider = {
                  puck = "${base04}";
                  backgroundhover = "${base03}";
                  background = "${base03}";
                  primary = "${base0A}";
                };
                icons = {
                  active = "${base0A}";
                  passive = "${base04}";
                };
                listitems = {
                  active = "${base0A}";
                  passive = "${base05}";
                };
                text = "${base05}";
                label = { color = "${base0A}"; };
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
                card = { color = "${base00}"; };
              };
              systray = {
                dropdownmenu = {
                  divider = "${base00}";
                  text = "${base05}";
                  background = "${base01}";
                };
              };
              bluetooth = {
                scaling = 70;
                iconbutton = {
                  active = "${base0C}";
                  passive = "${base05}";
                };
                icons = {
                  active = "${base0C}";
                  passive = "${base04}";
                };
                listitems = {
                  active = "${base0C}";
                  passive = "${base05}";
                };
                switch = {
                  puck = "${base04}";
                  disabled = "${base04}";
                  enabled = "${base0C}";
                  divider = "${base03}";
                };
                status = "${base04}";
                text = "${base05}";
                label = { color = "${base0C}"; };
                scroller = { color = "${base0C}"; };
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
                card = { color = "${base00}"; };
              };
              network = {
                scaling = 70;
                iconbuttons = {
                  active = "${base0E}";
                  passive = "${base05}";
                };
                icons = {
                  active = "${base0E}";
                  passive = "${base04}";
                };
                listitems = {
                  active = "${base0E}";
                  passive = "${base05}";
                };
                status = { color = "${base04}"; };
                text = "${base05}";
                label = { color = "${base0E}"; };
                scroller = { color = "${base0E}"; };
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
                card = { color = "${base00}"; };
                switch = {
                  enabled = "${base0E}";
                  disabled = "${base04}";
                  puck = "${base04}";
                };
              };
              volume = {
                scaling = 70;
                input_slider = {
                  puck = "${base04}";
                  backgroundhover = "${base03}";
                  background = "${base03}";
                  primary = "${base0B}";
                };
                audio_slider = {
                  puck = "${base04}";
                  backgroundhover = "${base03}";
                  background = "${base03}";
                  primary = "${base0D}";
                };
                icons = {
                  active = "${base06}";
                  passive = "${base04}";
                };
                iconbutton = {
                  active = "${base06}";
                  passive = "${base05}";
                };
                listitems = {
                  active = "${base0D}";
                  passive = "${base04}";
                };
                text = "${base05}";
                label = { color = "${base06}"; };
                border = { color = "${base02}"; };
                background = { color = "${base01}"; };
                card = { color = "${base00}"; };
              };
              media = {
                scaling = 70;
                slider = {
                  puck = "${base04}";
                  backgroundhover = "${base03}";
                  background = "${base03}";
                  primary = "${base09}";
                };
                buttons = {
                  text = "${base01}";
                  background = "${base0D}";
                  enabled = "${base0C}";
                  inactive = "${base04}";
                };
                border = { color = "${base02}"; };
                card = { color = "${base00}"; };
                background = { color = "${base01}"; };
                album = "${base0F}";
                timestamp = "${base05}";
                artist = "${base0B}";
                song = "${base0D}";
              };
            };
            tooltip = {
              scaling = 70;
              text = "${base05}";
              background = "${base01}";
            };
            dropdownmenu = {
              divider = "${base00}";
              text = "${base05}";
              background = "${base01}";
            };
            slider = {
              puck = "${base04}";
              backgroundhover = "${base03}";
              background = "${base02}";
              primary = "${base07}";
            };
            progressbar = {
              background = "${base03}";
              foreground = "${base07}";
            };
            iconbuttons = {
              active = "${base0D}";
              passive = "${base05}";
            };
            buttons = {
              text = "${base01}";
              disabled = "${base04}";
              active = "${base0F}";
              default = "${base07}";
            };
            check_radio_button = {
              active = "${base0D}";
              background = "${base03}";
            };
            switch = {
              puck = "${base04}";
              disabled = "${base03}";
              enabled = "${base07}";
            };
            icons = {
              active = "${base07}";
              passive = "${base04}";
            };
            listitems = {
              active = "${base0D}";
              passive = "${base05}";
            };
            popover = {
              scaling = 70;
              border = "${base01}";
              background = "${base01}";
              text = "${base07}";
            };
            label = "${base07}";
            feinttext = "${base02}";
            dimtext = "${base04}";
            text = "${base05}";
            border = { color = "${base02}"; };
            cards = "${base00}";
            background = "${base01}";
          };
          buttons = {
            modules = {
              power = {
                icon_background = "${base08}";
                icon = "${base08}";
                background = "${base00}";
                border = "${base08}";
              };
              weather = {
                icon_background = "${base07}";
                icon = "${base07}";
                text = "${base07}";
                background = "${base00}";
                border = "${base07}";
              };
              updates = {
                icon_background = "${base0E}";
                icon = "${base0E}";
                text = "${base0E}";
                background = "${base00}";
                border = "${base0E}";
              };
              kbLayout = {
                icon_background = "${base0C}";
                icon = "${base0C}";
                text = "${base0C}";
                background = "${base00}";
                border = "${base0C}";
              };
              netstat = {
                icon_background = "${base0B}";
                icon = "${base0B}";
                text = "${base0B}";
                background = "${base00}";
                border = "${base0B}";
              };
              storage = {
                icon_background = "${base06}";
                icon = "${base06}";
                text = "${base06}";
                background = "${base00}";
                border = "${base06}";
              };
              cpu = {
                icon_background = "${base08}";
                icon = "${base08}";
                text = "${base08}";
                background = "${base00}";
                border = "${base08}";
              };
              ram = {
                icon_background = "${base0A}";
                icon = "${base0A}";
                text = "${base0A}";
                background = "${base00}";
                border = "${base0A}";
              };
              hyprsunset = {
                icon = "${base09}";
                background = "${base00}";
                icon_background = "${base00}";
                text = "${base09}";
                border = "${base06}";
              };
              hypridle = {
                icon = "${base0C}";
                background = "${base00}";
                icon_background = "${base06}";
                text = "${base06}";
                border = "${base06}";
              };
              cava = {
                text = "${base0C}";
                background = "${base00}";
                icon_background = "${base00}";
                icon = "${base0C}";
                border = "${base0C}";
              };
              worldclock = {
                text = "${base08}";
                background = "${base00}";
                icon_background = "${base06}";
                icon = "${base06}";
                border = "${base06}";
              };
              microphone = {
                border = "${base0B}";
                background = "${base00}";
                text = "${base0B}";
                icon = "${base0B}";
                icon_background = "${base00}";
              };
              submap = {
                icon = "${base0C}";
                background = "${base00}";
                icon_background = "${base00}";
                text = "${base0C}";
                border = "${base0C}";
              };
            };
            notifications = {
              total = "${base07}";
              icon_background = "${base07}";
              icon = "${base0A}";
              background = "${base00}";
              border = "${base07}";
            };
            clock = {
              icon_background = "${base06}";
              icon = "${base0B}";
              text = "${base0B}";
              background = "${base00}";
              border = "${base06}";
            };
            battery = {
              icon_background = "${base0A}";
              icon = "${base0A}";
              text = "${base0A}";
              background = "${base00}";
              border = "${base0A}";
            };
            systray = {
              background = "${base00}";
              border = "${base07}";
              customIcon = "${base05}";
            };
            bluetooth = {
              icon_background = "${base0C}";
              icon = "${base0C}";
              text = "${base0C}";
              background = "${base00}";
              border = "${base0C}";
            };
            network = {
              icon_background = "${base0E}";
              icon = "${base0E}";
              text = "${base0E}";
              background = "${base00}";
              border = "${base0E}";
            };
            volume = {
              icon_background = "${base09}";
              icon = "${base09}";
              text = "${base09}";
              background = "${base00}";
              border = "${base09}";
            };
            media = {
              icon_background = "${base07}";
              icon = "${base08}";
              text = "${base08}";
              background = "${base00}";
              border = "${base07}";
            };
            windowtitle = {
              icon_background = "${base06}";
              icon = "${base06}";
              text = "${base06}";
              border = "${base06}";
              background = "${base00}";
            };
            workspaces = {
              numbered_active_underline_color = "${base0B}";
              numbered_active_highlighted_text_color = "${base01}";
              hover = "${base0D}";
              active = "${base0B}";
              occupied = "${base0F}";
              available = "${base0C}";
              border = "${base06}";
              background = "${base00}";
            };
            dashboard = {
              icon = "${base0A}";
              border = "${base0A}";
              background = "${base00}";
            };
            icon = "${base07}";
            text = "${base07}";
            hover = "${base03}";
            icon_background = "${base00}";
            background = "${base00}";
            borderColor = "${base07}";
            style = "default";
          };
          background = "${base01}";
          border = { color = "${base07}"; };
        };
        osd = {
          scaling = 70;
          label = "${base0D}";
          icon = "${base01}";
          bar_overflow_color = "${base08}";
          bar_empty_color = "${base02}";
          bar_color = "${base0D}";
          icon_container = "${base0D}";
          bar_container = "${base01}";
        };
        notification = {
          scaling = 70;
          close_button = {
            label = "${base01}";
            background = "${base08}";
          };
          labelicon = "${base07}";
          text = "${base05}";
          time = "${base04}";
          border = "${base03}";
          label = "${base07}";
          actions = {
            text = "${base01}";
            background = "${base0D}";
          };
          background = "${base01}";
        };
      };


      # General bar module settings
      bar = {
        launcher.icon = ""; #    
        workspaces = {
          show_numbered = false;
          numbered_active_indicator = "underline";
          # Ignore scratchpad workspaces with -9X numbers
          ignored = "-9*";
          showAllActive = true;
          showWsIcons = true;
          showApplicationIcons = false;
          # workspaceIconMap = {
          #   "1" = "";
          #   "2"= "";
          #   "3"= "";
          #   "4"= "";
          #   "5"= "";
          #   "6"= "";
          #   "7"= "";
          #   "8"= "";
          #   "9"= "";
          #   "10"= "";
          # };
        };
        # Volume module
        volume = {
          # Scroll up and down to change volume
          scrollUp = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          scrollDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          # right click to quickly toggle mute
          rightClick = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          # Middle click to Open volume settings
          middleClick = "pwvucontrol";
        };

        # systray module
        systray = {
          customIcons = {
            "spotify-client" = {
              color = "${base0B}";
              icon = "󰓇";
              size = "1.4em";
            };
            "udiskie" = {
              color = "${base07}";
              icon = "";
              size = "1.4em";
            };
            "nm-applet" = {
              color = "${base0E}";
              icon = "";
              size = "1.4em";
            };
            "blueman" = {
              color = "${base0C}";
              icon = "";
              #size = "1.4em";
            };
            "steam" = {
              color = "${base05}";
              icon = "";
              size = "1.2em";
            };
            "Zeal" = {
              color = "${base0A}";
              icon = "";
              #size = "1.4em";
            };
          };
        };

        # Media module
        media = { middleClick = "playerctl --player playerctld play-pause"; };

        customModules = {
          hypridle = {
            label = false;
            offIcon = "";
            onIcon = "";
          };
        };

      };

      # Settings for the dropdown menus themselves
      menus = {
        # Settings for dashboard menu
        dashboard = {

          powermenu.avatar.image = "${config.home.homeDirectory}/profile.png";

          # Directory shortcuts
          directories = {
            # Left column
            left = {
              directory1 = {
                command = "bash -c 'xdg-open $XDG_DOWNLOAD_DIR'";
              };
              directory2 = { command = "bash -c 'xdg-open $XDG_VIDEOS_DIR'"; };
              directory3 = { command = "bash -c 'xdg-open $HOME/projects/'"; };
            };
            right = {
              directory1 = {
                command = "bash -c 'xdg-open $XDG_DOCUMENTS_DIR'";
              };
              directory2 = {
                command = "bash -c 'xdg-open $XDG_PICTURES_DIR'";
              };
            };
          };
          shortcuts = {
            left = {
              # Firefox
              shortcut1 = {
                command = "firefox";
                tooltip = "Firefox";
                icon = "";
              };
              # Spotify
              shortcut2 = { command = "spotify"; };
              # Timer
              shortcut3 = {
                command = "gnome-clocks";
                tooltip = "Timer";
                icon = "";
              };
              # App Launcher
              shortcut4 = { command = "wofi --show drun"; };
            };
            right = {
              # Screenshot
              shortcut3 = {
                command = "hyprshot -m region --raw | swappy -f -";
              };
            };
          };
        };

        clock = {
          weather = {
            key = "${osConfig.sops.secrets."weatherapi/apikey.json".path}";
            location = "New York";
          };
        };
      };

      # Default bar layouts - can be overridden by host-specific configs using mkForce
      "bar.layouts" = {
        # Primary monitor (laptop screen, or main desktop monitor)
        "0" = {
          left = [ "dashboard" "workspaces" ];
          middle = [ "media" ];
          right = lib.flatten [
            "volume"
            "network"
            (lib.optional (osConfig.hardware.bluetooth.enable or false) "bluetooth")
            (lib.optional (osConfig.powerManagement.enable or false) "battery")
            "clock"
            "systray"
            "hypridle"
            "notifications"
          ];
        };
        # Secondary monitor (if connected)
        "1" = {
          left = [ "dashboard" "workspaces" ];
          middle = [ "media" ];
          right = [ "volume" "clock" "notifications" ];
        };
      };
    };
  };
}
