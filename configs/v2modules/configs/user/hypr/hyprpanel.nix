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

      # "theme.bar.menus.menu.notifications.scrollbar.color" = "${base07}";
      # "theme.bar.menus.menu.notifications.pager.label" = "${base04}";
      # "theme.bar.menus.menu.notifications.pager.button" = "${base0E}";
      # "theme.bar.menus.menu.notifications.pager.background" = "${base01}";
      # "theme.bar.menus.menu.notifications.switch.puck" = "${base00}";
      # "theme.bar.menus.menu.notifications.switch.disabled" = "${base08}";
      # "theme.bar.menus.menu.notifications.switch.enabled" = "${base0B}";
      # "theme.bar.menus.menu.notifications.clear" = "${base08}";
      # "theme.bar.menus.menu.notifications.switch_divider" = "${base03}";
      # "theme.bar.menus.menu.notifications.border" = "${base02}";
      # "theme.bar.menus.menu.notifications.card" = "${base00}";
      # "theme.bar.menus.menu.notifications.background" = "${base01}";
      # "theme.bar.menus.menu.notifications.no_notifications_label" = "${base02}";
      # "theme.bar.menus.menu.notifications.label" = "${base07}";
      # "theme.bar.menus.menu.power.buttons.sleep.icon" = "${base01}";
      # "theme.bar.menus.menu.power.buttons.sleep.text" = "${base0C}";
      # "theme.bar.menus.menu.power.buttons.sleep.icon_background" = "${base0C}";
      # "theme.bar.menus.menu.power.buttons.sleep.background" = "${base00}";
      # "theme.bar.menus.menu.power.buttons.logout.icon" = "${base01}";
      # "theme.bar.menus.menu.power.buttons.logout.text" = "${base0B}";
      # "theme.bar.menus.menu.power.buttons.logout.icon_background" = "${base0B}";
      # "theme.bar.menus.menu.power.buttons.logout.background" = "${base00}";
      # "theme.bar.menus.menu.power.buttons.restart.icon" = "${base01}";
      # "theme.bar.menus.menu.power.buttons.restart.text" = "${base09}";
      # "theme.bar.menus.menu.power.buttons.restart.icon_background" =
      #   "${base09}";
      # "theme.bar.menus.menu.power.buttons.restart.background" = "${base00}";
      # "theme.bar.menus.menu.power.buttons.shutdown.icon" = "${base01}";
      # "theme.bar.menus.menu.power.buttons.shutdown.text" = "${base08}";
      # "theme.bar.menus.menu.power.buttons.shutdown.icon_background" =
      #   "${base08}";
      # "theme.bar.menus.menu.power.buttons.shutdown.background" = "${base00}";
      # "theme.bar.menus.menu.power.border.color" = "${base02}";
      # "theme.bar.menus.menu.power.background.color" = "${base01}";
      # "theme.bar.menus.menu.dashboard.monitors.disk.label" = "${base0D}";
      # "theme.bar.menus.menu.dashboard.monitors.disk.bar" = "${base0D}";
      # "theme.bar.menus.menu.dashboard.monitors.disk.icon" = "${base0D}";
      # "theme.bar.menus.menu.dashboard.monitors.gpu.label" = "${base0B}";
      # "theme.bar.menus.menu.dashboard.monitors.gpu.bar" = "${base0B}";
      # "theme.bar.menus.menu.dashboard.monitors.gpu.icon" = "${base0B}";
      # "theme.bar.menus.menu.dashboard.monitors.ram.label" = "${base0A}";
      # "theme.bar.menus.menu.dashboard.monitors.ram.bar" = "${base0A}";
      # "theme.bar.menus.menu.dashboard.monitors.ram.icon" = "${base0A}";
      # "theme.bar.menus.menu.dashboard.monitors.cpu.label" = "${base08}";
      # "theme.bar.menus.menu.dashboard.monitors.cpu.bar" = "${base08}";
      # "theme.bar.menus.menu.dashboard.monitors.cpu.icon" = "${base08}";
      # "theme.bar.menus.menu.dashboard.monitors.bar_background" = "${base03}";
      # "theme.bar.menus.menu.dashboard.directories.right.bottom.color" =
      #   "${base08}";
      # "theme.bar.menus.menu.dashboard.directories.right.middle.color" =
      #   "${base0E}";
      # "theme.bar.menus.menu.dashboard.directories.right.top.color" =
      #   "${base0C}";
      # "theme.bar.menus.menu.dashboard.directories.left.bottom.color" =
      #   "${base0B}";
      # "theme.bar.menus.menu.dashboard.directories.left.middle.color" =
      #   "${base0A}";
      # "theme.bar.menus.menu.dashboard.directories.left.top.color" = "${base09}";
      # "theme.bar.menus.menu.dashboard.controls.input.text" = "${base01}";
      # "theme.bar.menus.menu.dashboard.controls.input.background" = "${base09}";
      # "theme.bar.menus.menu.dashboard.controls.volume.text" = "${base01}";
      # "theme.bar.menus.menu.dashboard.controls.volume.background" = "${base0B}";
      # "theme.bar.menus.menu.dashboard.controls.notifications.text" =
      #   "${base01}";
      # "theme.bar.menus.menu.dashboard.controls.notifications.background" =
      #   "${base0A}";
      # "theme.bar.menus.menu.dashboard.controls.bluetooth.text" = "${base01}";
      # "theme.bar.menus.menu.dashboard.controls.bluetooth.background" =
      #   "${base0C}";
      # "theme.bar.menus.menu.dashboard.controls.wifi.text" = "${base01}";
      # "theme.bar.menus.menu.dashboard.controls.wifi.background" = "${base0E}";
      # "theme.bar.menus.menu.dashboard.controls.disabled" = "${base04}";
      # "theme.bar.menus.menu.dashboard.shortcuts.recording" = "${base0B}";
      # "theme.bar.menus.menu.dashboard.shortcuts.text" = "${base01}";
      # "theme.bar.menus.menu.dashboard.shortcuts.background" = "${base0D}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.button_text" =
      #   "${base01}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.deny" =
      #   "${base08}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.confirm" =
      #   "${base0B}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.body" =
      #   "${base05}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.label" =
      #   "${base07}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.border" =
      #   "${base02}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.background" =
      #   "${base01}";
      # "theme.bar.menus.menu.dashboard.powermenu.confirmation.card" =
      #   "${base00}";
      # "theme.bar.menus.menu.dashboard.powermenu.sleep" = "${base0C}";
      # "theme.bar.menus.menu.dashboard.powermenu.logout" = "${base0B}";
      # "theme.bar.menus.menu.dashboard.powermenu.restart" = "${base09}";
      # "theme.bar.menus.menu.dashboard.powermenu.shutdown" = "${base08}";
      # "theme.bar.menus.menu.dashboard.profile.name" = "${base06}";
      # "theme.bar.menus.menu.dashboard.border.color" = "${base02}";
      # "theme.bar.menus.menu.dashboard.background.color" = "${base01}";
      # "theme.bar.menus.menu.dashboard.card.color" = "${base00}";
      # "theme.bar.menus.menu.clock.weather.hourly.temperature" = "${base06}";
      # "theme.bar.menus.menu.clock.weather.hourly.icon" = "${base06}";
      # "theme.bar.menus.menu.clock.weather.hourly.time" = "${base06}";
      # "theme.bar.menus.menu.clock.weather.thermometer.extremelycold" =
      #   "${base0C}";
      # "theme.bar.menus.menu.clock.weather.thermometer.cold" = "${base0D}";
      # "theme.bar.menus.menu.clock.weather.thermometer.moderate" = "${base07}";
      # "theme.bar.menus.menu.clock.weather.thermometer.hot" = "${base09}";
      # "theme.bar.menus.menu.clock.weather.thermometer.extremelyhot" =
      #   "${base08}";
      # "theme.bar.menus.menu.clock.weather.stats" = "${base06}";
      # "theme.bar.menus.menu.clock.weather.status" = "${base0C}";
      # "theme.bar.menus.menu.clock.weather.temperature" = "${base05}";
      # "theme.bar.menus.menu.clock.weather.icon" = "${base06}";
      # "theme.bar.menus.menu.clock.calendar.contextdays" = "${base04}";
      # "theme.bar.menus.menu.clock.calendar.days" = "${base05}";
      # "theme.bar.menus.menu.clock.calendar.currentday" = "${base06}";
      # "theme.bar.menus.menu.clock.calendar.paginator" = "${base0F}";
      # "theme.bar.menus.menu.clock.calendar.weekdays" = "${base06}";
      # "theme.bar.menus.menu.clock.calendar.yearmonth" = "${base0C}";
      # "theme.bar.menus.menu.clock.time.timeperiod" = "${base0C}";
      # "theme.bar.menus.menu.clock.time.time" = "${base06}";
      # "theme.bar.menus.menu.clock.text" = "${base05}";
      # "theme.bar.menus.menu.clock.border.color" = "${base02}";
      # "theme.bar.menus.menu.clock.background.color" = "${base01}";
      # "theme.bar.menus.menu.clock.card.color" = "${base00}";
      # "theme.bar.menus.menu.battery.slider.puck" = "${base04}";
      # "theme.bar.menus.menu.battery.slider.backgroundhover" = "${base03}";
      # "theme.bar.menus.menu.battery.slider.background" = "${base03}";
      # "theme.bar.menus.menu.battery.slider.primary" = "${base0A}";
      # "theme.bar.menus.menu.battery.icons.active" = "${base0A}";
      # "theme.bar.menus.menu.battery.icons.passive" = "${base04}";
      # "theme.bar.menus.menu.battery.listitems.active" = "${base0A}";
      # "theme.bar.menus.menu.battery.listitems.passive" = "${base05}";
      # "theme.bar.menus.menu.battery.text" = "${base05}";
      # "theme.bar.menus.menu.battery.label.color" = "${base0A}";
      # "theme.bar.menus.menu.battery.border.color" = "${base02}";
      # "theme.bar.menus.menu.battery.background.color" = "${base01}";
      # "theme.bar.menus.menu.battery.card.color" = "${base00}";
      # "theme.bar.menus.menu.systray.dropdownmenu.divider" = "${base00}";
      # "theme.bar.menus.menu.systray.dropdownmenu.text" = "${base05}";
      # "theme.bar.menus.menu.systray.dropdownmenu.background" = "${base01}";
      # "theme.bar.menus.menu.bluetooth.iconbutton.active" = "${base0C}";
      # "theme.bar.menus.menu.bluetooth.iconbutton.passive" = "${base05}";
      # "theme.bar.menus.menu.bluetooth.icons.active" = "${base0C}";
      # "theme.bar.menus.menu.bluetooth.icons.passive" = "${base04}";
      # "theme.bar.menus.menu.bluetooth.listitems.active" = "${base0C}";
      # "theme.bar.menus.menu.bluetooth.listitems.passive" = "${base05}";
      # "theme.bar.menus.menu.bluetooth.switch.puck" = "${base04}";
      # "theme.bar.menus.menu.bluetooth.switch.disabled" = "${base04}";
      # "theme.bar.menus.menu.bluetooth.switch.enabled" = "${base0C}";
      # "theme.bar.menus.menu.bluetooth.switch_divider" = "${base03}";
      # "theme.bar.menus.menu.bluetooth.status" = "${base04}";
      # "theme.bar.menus.menu.bluetooth.text" = "${base05}";
      # "theme.bar.menus.menu.bluetooth.label.color" = "${base0C}";
      # "theme.bar.menus.menu.bluetooth.scroller.color" = "${base0C}";
      # "theme.bar.menus.menu.bluetooth.border.color" = "${base02}";
      # "theme.bar.menus.menu.bluetooth.background.color" = "${base01}";
      # "theme.bar.menus.menu.bluetooth.card.color" = "${base00}";
      # "theme.bar.menus.menu.network.iconbuttons.active" = "${base0E}";
      # "theme.bar.menus.menu.network.iconbuttons.passive" = "${base05}";
      # "theme.bar.menus.menu.network.icons.active" = "${base0E}";
      # "theme.bar.menus.menu.network.icons.passive" = "${base04}";
      # "theme.bar.menus.menu.network.listitems.active" = "${base0E}";
      # "theme.bar.menus.menu.network.listitems.passive" = "${base05}";
      # "theme.bar.menus.menu.network.status.color" = "${base04}";
      # "theme.bar.menus.menu.network.text" = "${base05}";
      # "theme.bar.menus.menu.network.label.color" = "${base0E}";
      # "theme.bar.menus.menu.network.scroller.color" = "${base0E}";
      # "theme.bar.menus.menu.network.border.color" = "${base02}";
      # "theme.bar.menus.menu.network.background.color" = "${base01}";
      # "theme.bar.menus.menu.network.card.color" = "${base00}";
      # "theme.bar.menus.menu.volume.input_slider.puck" = "${base04}";
      # "theme.bar.menus.menu.volume.input_slider.backgroundhover" = "${base03}";
      # "theme.bar.menus.menu.volume.input_slider.background" = "${base03}";
      # "theme.bar.menus.menu.volume.input_slider.primary" = "${base0B}";
      # "theme.bar.menus.menu.volume.audio_slider.puck" = "${base04}";
      # "theme.bar.menus.menu.volume.audio_slider.backgroundhover" = "${base03}";
      # "theme.bar.menus.menu.volume.audio_slider.background" = "${base03}";
      # "theme.bar.menus.menu.volume.audio_slider.primary" = "${base0D}";
      # "theme.bar.menus.menu.volume.icons.active" = "${base06}";
      # "theme.bar.menus.menu.volume.icons.passive" = "${base04}";
      # "theme.bar.menus.menu.volume.iconbutton.active" = "${base06}";
      # "theme.bar.menus.menu.volume.iconbutton.passive" = "${base05}";
      # "theme.bar.menus.menu.volume.listitems.active" = "${base0D}";
      # "theme.bar.menus.menu.volume.listitems.passive" = "${base04}";
      # "theme.bar.menus.menu.volume.text" = "${base05}";
      # "theme.bar.menus.menu.volume.label.color" = "${base06}";
      # "theme.bar.menus.menu.volume.border.color" = "${base02}";
      # "theme.bar.menus.menu.volume.background.color" = "${base01}";
      # "theme.bar.menus.menu.volume.card.color" = "${base00}";
      # "theme.bar.menus.menu.media.slider.puck" = "${base04}";
      # "theme.bar.menus.menu.media.slider.backgroundhover" = "${base03}";
      # "theme.bar.menus.menu.media.slider.background" = "${base03}";
      # "theme.bar.menus.menu.media.slider.primary" = "${base09}";
      # "theme.bar.menus.menu.media.buttons.text" = "${base01}";
      # "theme.bar.menus.menu.media.buttons.background" = "${base0D}";
      # "theme.bar.menus.menu.media.buttons.enabled" = "${base0C}";
      # "theme.bar.menus.menu.media.buttons.inactive" = "${base04}";
      # "theme.bar.menus.menu.media.border.color" = "${base02}";
      # "theme.bar.menus.menu.media.card.color" = "${base00}";
      # "theme.bar.menus.menu.media.background.color" = "${base01}";
      # "theme.bar.menus.menu.media.album" = "${base0F}";
      # "theme.bar.menus.menu.media.timestamp" = "${base05}";
      # "theme.bar.menus.menu.media.artist" = "${base0B}";
      # "theme.bar.menus.menu.media.song" = "${base0D}";
      # "theme.bar.menus.tooltip.text" = "${base05}";
      # "theme.bar.menus.tooltip.background" = "${base01}";
      # "theme.bar.menus.dropdownmenu.divider" = "${base00}";
      # "theme.bar.menus.dropdownmenu.text" = "${base05}";
      # "theme.bar.menus.dropdownmenu.background" = "${base01}";
      # "theme.bar.menus.slider.puck" = "${base04}";
      # "theme.bar.menus.slider.backgroundhover" = "${base03}";
      # "theme.bar.menus.slider.background" = "${base02}";
      # "theme.bar.menus.slider.primary" = "${base07}";
      # "theme.bar.menus.progressbar.background" = "${base03}";
      # "theme.bar.menus.progressbar.foreground" = "${base07}";
      # "theme.bar.menus.iconbuttons.active" = "${base0D}";
      # "theme.bar.menus.iconbuttons.passive" = "${base05}";
      # "theme.bar.menus.buttons.text" = "${base01}";
      # "theme.bar.menus.buttons.disabled" = "${base04}";
      # "theme.bar.menus.buttons.active" = "${base0F}";
      # "theme.bar.menus.buttons.default" = "${base07}";
      # "theme.bar.menus.check_radio_button.active" = "${base0D}";
      # "theme.bar.menus.check_radio_button.background" = "${base03}";
      # "theme.bar.menus.switch.puck" = "${base04}";
      # "theme.bar.menus.switch.disabled" = "${base03}";
      # "theme.bar.menus.switch.enabled" = "${base07}";
      # "theme.bar.menus.icons.active" = "${base07}";
      # "theme.bar.menus.icons.passive" = "${base04}";
      # "theme.bar.menus.listitems.active" = "${base0D}";
      # "theme.bar.menus.listitems.passive" = "${base05}";
      # "theme.bar.menus.popover.border" = "${base01}";
      # "theme.bar.menus.popover.background" = "${base01}";
      # "theme.bar.menus.popover.text" = "${base07}";
      # "theme.bar.menus.label" = "${base07}";
      # "theme.bar.menus.feinttext" = "${base02}";
      # "theme.bar.menus.dimtext" = "${base04}";
      # "theme.bar.menus.text" = "${base05}";
      # "theme.bar.menus.border.color" = "${base02}";
      # "theme.bar.menus.cards" = "${base00}";
      # "theme.bar.menus.background" = "${base01}";
      # "theme.bar.buttons.modules.power.icon_background" = "${base08}";
      # "theme.bar.buttons.modules.power.icon" = "${base08}";
      # "theme.bar.buttons.modules.power.background" = "${base00}";
      # "theme.bar.buttons.modules.power.border" = "${base08}";
      # "theme.bar.buttons.modules.weather.icon_background" = "${base07}";
      # "theme.bar.buttons.modules.weather.icon" = "${base07}";
      # "theme.bar.buttons.modules.weather.text" = "${base07}";
      # "theme.bar.buttons.modules.weather.background" = "${base00}";
      # "theme.bar.buttons.modules.weather.border" = "${base07}";
      # "theme.bar.buttons.modules.updates.icon_background" = "${base0E}";
      # "theme.bar.buttons.modules.updates.icon" = "${base0E}";
      # "theme.bar.buttons.modules.updates.text" = "${base0E}";
      # "theme.bar.buttons.modules.updates.background" = "${base00}";
      # "theme.bar.buttons.modules.updates.border" = "${base0E}";
      # "theme.bar.buttons.modules.kbLayout.icon_background" = "${base0C}";
      # "theme.bar.buttons.modules.kbLayout.icon" = "${base0C}";
      # "theme.bar.buttons.modules.kbLayout.text" = "${base0C}";
      # "theme.bar.buttons.modules.kbLayout.background" = "${base00}";
      # "theme.bar.buttons.modules.kbLayout.border" = "${base0C}";
      # "theme.bar.buttons.modules.netstat.icon_background" = "${base0B}";
      # "theme.bar.buttons.modules.netstat.icon" = "${base0B}";
      # "theme.bar.buttons.modules.netstat.text" = "${base0B}";
      # "theme.bar.buttons.modules.netstat.background" = "${base00}";
      # "theme.bar.buttons.modules.netstat.border" = "${base0B}";
      # "theme.bar.buttons.modules.storage.icon_background" = "${base06}";
      # "theme.bar.buttons.modules.storage.icon" = "${base06}";
      # "theme.bar.buttons.modules.storage.text" = "${base06}";
      # "theme.bar.buttons.modules.storage.background" = "${base00}";
      # "theme.bar.buttons.modules.storage.border" = "${base06}";
      # "theme.bar.buttons.modules.cpu.icon_background" = "${base08}";
      # "theme.bar.buttons.modules.cpu.icon" = "${base08}";
      # "theme.bar.buttons.modules.cpu.text" = "${base08}";
      # "theme.bar.buttons.modules.cpu.background" = "${base00}";
      # "theme.bar.buttons.modules.cpu.border" = "${base08}";
      # "theme.bar.buttons.modules.ram.icon_background" = "${base0A}";
      # "theme.bar.buttons.modules.ram.icon" = "${base0A}";
      # "theme.bar.buttons.modules.ram.text" = "${base0A}";
      # "theme.bar.buttons.modules.ram.background" = "${base00}";
      # "theme.bar.buttons.modules.ram.border" = "${base0A}";
      # "theme.bar.buttons.notifications.total" = "${base07}";
      # "theme.bar.buttons.notifications.icon_background" = "${base07}";
      # "theme.bar.buttons.notifications.icon" = "${base0B}";
      # "theme.bar.buttons.notifications.background" = "${base00}";
      # "theme.bar.buttons.notifications.border" = "${base07}";
      # "theme.bar.buttons.clock.icon_background" = "${base06}";
      # "theme.bar.buttons.clock.icon" = "${base0B}";
      # "theme.bar.buttons.clock.text" = "${base0B}";
      # "theme.bar.buttons.clock.background" = "${base00}";
      # "theme.bar.buttons.clock.border" = "${base06}";
      # "theme.bar.buttons.battery.icon_background" = "${base0A}";
      # "theme.bar.buttons.battery.icon" = "${base0A}";
      # "theme.bar.buttons.battery.text" = "${base0A}";
      # "theme.bar.buttons.battery.background" = "${base00}";
      # "theme.bar.buttons.battery.border" = "${base0A}";
      # "theme.bar.buttons.systray.background" = "${base00}";
      # "theme.bar.buttons.systray.border" = "${base07}";
      # "theme.bar.buttons.systray.customIcon" = "${base05}";
      # "theme.bar.buttons.bluetooth.icon_background" = "${base0C}";
      # "theme.bar.buttons.bluetooth.icon" = "${base0C}";
      # "theme.bar.buttons.bluetooth.text" = "${base0C}";
      # "theme.bar.buttons.bluetooth.background" = "${base00}";
      # "theme.bar.buttons.bluetooth.border" = "${base0C}";
      # "theme.bar.buttons.network.icon_background" = "${base0E}";
      # "theme.bar.buttons.network.icon" = "${base0E}";
      # "theme.bar.buttons.network.text" = "${base0E}";
      # "theme.bar.buttons.network.background" = "${base00}";
      # "theme.bar.buttons.network.border" = "${base0E}";
      # "theme.bar.buttons.volume.icon_background" = "${base09}";
      # "theme.bar.buttons.volume.icon" = "${base09}";
      # "theme.bar.buttons.volume.text" = "${base09}";
      # "theme.bar.buttons.volume.background" = "${base00}";
      # "theme.bar.buttons.volume.border" = "${base09}";
      # "theme.bar.buttons.media.icon_background" = "${base07}";
      # "theme.bar.buttons.media.icon" = "${base08}";
      # "theme.bar.buttons.media.text" = "${base08}";
      # "theme.bar.buttons.media.background" = "${base00}";
      # "theme.bar.buttons.media.border" = "${base07}";
      # "theme.bar.buttons.windowtitle.icon_background" = "${base06}";
      # "theme.bar.buttons.windowtitle.icon" = "${base06}";
      # "theme.bar.buttons.windowtitle.text" = "${base06}";
      # "theme.bar.buttons.windowtitle.border" = "${base06}";
      # "theme.bar.buttons.windowtitle.background" = "${base00}";
      # "theme.bar.buttons.workspaces.numbered_active_underline_color" =
      #   "${base0B}";
      # "theme.bar.buttons.workspaces.numbered_active_highlighted_text_color" =
      #   "${base01}";
      # "theme.bar.buttons.workspaces.hover" = "${base0D}";
      # "theme.bar.buttons.workspaces.active" = "${base0B}";
      # "theme.bar.buttons.workspaces.occupied" = "${base0F}";
      # "theme.bar.buttons.workspaces.available" = "${base0C}";
      # "theme.bar.buttons.workspaces.border" = "${base06}";
      # "theme.bar.buttons.workspaces.background" = "${base00}";
      # "theme.bar.buttons.dashboard.icon" = "${base0A}";
      # "theme.bar.buttons.dashboard.border" = "${base0A}";
      # "theme.bar.buttons.dashboard.background" = "${base00}";
      # "theme.bar.buttons.icon" = "${base07}";
      # "theme.bar.buttons.text" = "${base07}";
      # "theme.bar.buttons.hover" = "${base03}";
      # "theme.bar.buttons.icon_background" = "${base00}";
      # "theme.bar.buttons.background" = "${base00}";
      # "theme.bar.buttons.borderColor" = "${base07}";
      # "theme.bar.buttons.style" = "default";
      # "theme.bar.background" = "${base01}";
      # "theme.osd.label" = "${base0D}";
      # "theme.osd.icon" = "${base01}";
      # "theme.osd.bar_overflow_color" = "${base08}";
      # "theme.osd.bar_empty_color" = "${base02}";
      # "theme.osd.bar_color" = "${base0D}";
      # "theme.osd.icon_container" = "${base0D}";
      # "theme.osd.bar_container" = "${base01}";
      # "theme.notification.close_button.label" = "${base01}";
      # "theme.notification.close_button.background" = "${base08}";
      # "theme.notification.labelicon" = "${base07}";
      # "theme.notification.text" = "${base05}";
      # "theme.notification.time" = "${base04}";
      # "theme.notification.border" = "${base03}";
      # "theme.notification.label" = "${base07}";
      # "theme.notification.actions.text" = "${base01}";
      # "theme.notification.actions.background" = "${base0D}";
      # "theme.notification.background" = "${base01}";
      # "theme.bar.buttons.modules.submap.icon" = "${base0C}";
      # "theme.bar.buttons.modules.submap.background" = "${base00}";
      # "theme.bar.buttons.modules.submap.icon_background" = "${base00}";
      # "theme.bar.buttons.modules.submap.text" = "${base0C}";
      # "theme.bar.buttons.modules.submap.border" = "${base0C}";
      # "theme.bar.menus.menu.network.switch.enabled" = "${base0E}";
      # "theme.bar.menus.menu.network.switch.disabled" = "${base04}";
      # "theme.bar.menus.menu.network.switch.puck" = "${base04}";
      # "theme.bar.border.color" = "${base07}";
      # "theme.bar.buttons.modules.hyprsunset.icon" = "${base09}";
      # "theme.bar.buttons.modules.hyprsunset.background" = "${base00}";
      # "theme.bar.buttons.modules.hyprsunset.icon_background" = "${base00}";
      # "theme.bar.buttons.modules.hyprsunset.text" = "${base09}";
      # "theme.bar.buttons.modules.hyprsunset.border" = "${base06}";
      # "theme.bar.buttons.modules.hypridle.icon" = "${base0C}";
      # "theme.bar.buttons.modules.hypridle.background" = "${base00}";
      # "theme.bar.buttons.modules.hypridle.icon_background" = "${base06}";
      # "theme.bar.buttons.modules.hypridle.text" = "${base06}";
      # "theme.bar.buttons.modules.hypridle.border" = "${base06}";
      # "theme.bar.buttons.modules.cava.text" = "${base0C}";
      # "theme.bar.buttons.modules.cava.background" = "${base00}";
      # "theme.bar.buttons.modules.cava.icon_background" = "${base00}";
      # "theme.bar.buttons.modules.cava.icon" = "${base0C}";
      # "theme.bar.buttons.modules.cava.border" = "${base0C}";
      # "theme.bar.buttons.modules.worldclock.text" = "${base08}";
      # "theme.bar.buttons.modules.worldclock.background" = "${base00}";
      # "theme.bar.buttons.modules.worldclock.icon_background" = "${base06}";
      # "theme.bar.buttons.modules.worldclock.icon" = "${base06}";
      # "theme.bar.buttons.modules.worldclock.border" = "${base06}";
      # "theme.bar.buttons.modules.microphone.border" = "${base0B}";
      # "theme.bar.buttons.modules.microphone.background" = "${base00}";
      # "theme.bar.buttons.modules.microphone.text" = "${base0B}";
      # "theme.bar.buttons.modules.microphone.icon" = "${base0B}";
      # "theme.bar.buttons.modules.microphone.icon_background" = "${base00}";

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
    };

    # override = {
    #   # BUG: putting systray icons here for now
    #   # This isn't working anyways...
    #   "bar.systray.customIcons.spotify-client.icon" = "󰓇";
    #   "bar.systray.customIcons.spotify-client.color" = "${green}";
    #
    #   # BUG: putting theme here for now
    # };

  };

}
