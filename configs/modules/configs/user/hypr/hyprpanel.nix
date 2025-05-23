{ pkgs, lib, config, osConfig, ... }:

with config.lib.stylix.colors.withHashtag;

{

  programs.hyprpanel = {
    enable = true;

    # apparently this is deprecated?
    #systemd.enable = true;

    # handle adding to hyprlands exec-once
    # this is good so hyprland config isnt 
    #polluted if we get rid of hyprpanel
    hyprland.enable = true;

    #allow HM generated file to be deleted for testing with GUI
    overwrite.enable = true;

    overlay.enable = true;

    settings = {

      theme = {
        # On Screen Display (volume/brightness changes)
        osd.scaling = 70;
        # incoming notifications
        notification.scaling = 70;
        # Scale the bar and its dropdown menus
        bar = {
          scaling = 75;
          floating = false;
          # move the dropdowns up a bit
          dropdownGap = "2.5em";
          menus = {
            popover.scaling = 80;
            menu = {
              dashboard.scaling = 70;
              dashboard.confirmation_scaling = 80;
              network.scaling = 80;
              bluetooth.scaling = 80;
              battery.scaling = 80;
              clock.scaling = 80;
              notifications.scaling = 80;
              power.scaling = 80;
              volume.scaling = 80;
              media.scaling = 80;
            };
          };
        };

        #BUG: this isnt' being applied
        font = { name = "${config.stylix.fonts.monospace.name}"; };
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

        # Media module
        media = { middleClick = "playerctl --player playerctld play-pause"; };

        #BUG: not working
        # systray.customIcons = {
        #   "spotify-client" = {
        #     icon = "󰓇";
        #     color = "${green}";
        #   };
        #   "ckb-next_ckb-next" = {
        #     icon = "";
        #     color = "${orange}";
        #   };
        #   "steam" = {
        #     icon = "󰓓";
        #     color = "${blue}";
        #   };
        # };

      };

      # Settings for the dropdown menus themselves
      menus = {
        # Settings for dashboard menu
        dashboard = {

          powermenu.avatar.image =
            "${config.home.homeDirectory}/nix/configs/users/${config.home.username}/configs/profile.png";

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
              # Discord
              shortcut3 = { command = "vesktop"; };
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

    # BUG: putting theme here for now
    override = {
      "theme.bar.menus.menu.notifications.scrollbar.color" = "${base07}";
      "theme.bar.menus.menu.notifications.pager.label" = "${base04}";
      "theme.bar.menus.menu.notifications.pager.button" = "${base0E}";
      "theme.bar.menus.menu.notifications.pager.background" = "${base01}";
      "theme.bar.menus.menu.notifications.switch.puck" = "${base00}";
      "theme.bar.menus.menu.notifications.switch.disabled" = "${base08}";
      "theme.bar.menus.menu.notifications.switch.enabled" = "${base0B}";
      "theme.bar.menus.menu.notifications.clear" = "${base08}";
      "theme.bar.menus.menu.notifications.switch_divider" = "${base03}";
      "theme.bar.menus.menu.notifications.border" = "${base02}";
      "theme.bar.menus.menu.notifications.card" = "${base00}";
      "theme.bar.menus.menu.notifications.background" = "${base01}";
      "theme.bar.menus.menu.notifications.no_notifications_label" = "${base02}";
      "theme.bar.menus.menu.notifications.label" = "${base07}";
      "theme.bar.menus.menu.power.buttons.sleep.icon" = "${base01}";
      "theme.bar.menus.menu.power.buttons.sleep.text" = "${base0C}";
      "theme.bar.menus.menu.power.buttons.sleep.icon_background" = "${base0C}";
      "theme.bar.menus.menu.power.buttons.sleep.background" = "${base00}";
      "theme.bar.menus.menu.power.buttons.logout.icon" = "${base01}";
      "theme.bar.menus.menu.power.buttons.logout.text" = "${base0B}";
      "theme.bar.menus.menu.power.buttons.logout.icon_background" = "${base0B}";
      "theme.bar.menus.menu.power.buttons.logout.background" = "${base00}";
      "theme.bar.menus.menu.power.buttons.restart.icon" = "${base01}";
      "theme.bar.menus.menu.power.buttons.restart.text" = "${base09}";
      "theme.bar.menus.menu.power.buttons.restart.icon_background" =
        "${base09}";
      "theme.bar.menus.menu.power.buttons.restart.background" = "${base00}";
      "theme.bar.menus.menu.power.buttons.shutdown.icon" = "${base01}";
      "theme.bar.menus.menu.power.buttons.shutdown.text" = "${base08}";
      "theme.bar.menus.menu.power.buttons.shutdown.icon_background" =
        "${base08}";
      "theme.bar.menus.menu.power.buttons.shutdown.background" = "${base00}";
      "theme.bar.menus.menu.power.border.color" = "${base02}";
      "theme.bar.menus.menu.power.background.color" = "${base01}";
      "theme.bar.menus.menu.dashboard.monitors.disk.label" = "${base0D}";
      "theme.bar.menus.menu.dashboard.monitors.disk.bar" = "${base0D}";
      "theme.bar.menus.menu.dashboard.monitors.disk.icon" = "${base0D}";
      "theme.bar.menus.menu.dashboard.monitors.gpu.label" = "${base0B}";
      "theme.bar.menus.menu.dashboard.monitors.gpu.bar" = "${base0B}";
      "theme.bar.menus.menu.dashboard.monitors.gpu.icon" = "${base0B}";
      "theme.bar.menus.menu.dashboard.monitors.ram.label" = "${base0A}";
      "theme.bar.menus.menu.dashboard.monitors.ram.bar" = "${base0A}";
      "theme.bar.menus.menu.dashboard.monitors.ram.icon" = "${base0A}";
      "theme.bar.menus.menu.dashboard.monitors.cpu.label" = "${base08}";
      "theme.bar.menus.menu.dashboard.monitors.cpu.bar" = "${base08}";
      "theme.bar.menus.menu.dashboard.monitors.cpu.icon" = "${base08}";
      "theme.bar.menus.menu.dashboard.monitors.bar_background" = "${base03}";
      "theme.bar.menus.menu.dashboard.directories.right.bottom.color" =
        "${base08}";
      "theme.bar.menus.menu.dashboard.directories.right.middle.color" =
        "${base0E}";
      "theme.bar.menus.menu.dashboard.directories.right.top.color" =
        "${base0C}";
      "theme.bar.menus.menu.dashboard.directories.left.bottom.color" =
        "${base0B}";
      "theme.bar.menus.menu.dashboard.directories.left.middle.color" =
        "${base0A}";
      "theme.bar.menus.menu.dashboard.directories.left.top.color" = "${base09}";
      "theme.bar.menus.menu.dashboard.controls.input.text" = "${base01}";
      "theme.bar.menus.menu.dashboard.controls.input.background" = "${base09}";
      "theme.bar.menus.menu.dashboard.controls.volume.text" = "${base01}";
      "theme.bar.menus.menu.dashboard.controls.volume.background" = "${base0B}";
      "theme.bar.menus.menu.dashboard.controls.notifications.text" =
        "${base01}";
      "theme.bar.menus.menu.dashboard.controls.notifications.background" =
        "${base0A}";
      "theme.bar.menus.menu.dashboard.controls.bluetooth.text" = "${base01}";
      "theme.bar.menus.menu.dashboard.controls.bluetooth.background" =
        "${base0C}";
      "theme.bar.menus.menu.dashboard.controls.wifi.text" = "${base01}";
      "theme.bar.menus.menu.dashboard.controls.wifi.background" = "${base0E}";
      "theme.bar.menus.menu.dashboard.controls.disabled" = "${base04}";
      "theme.bar.menus.menu.dashboard.shortcuts.recording" = "${base0B}";
      "theme.bar.menus.menu.dashboard.shortcuts.text" = "${base01}";
      "theme.bar.menus.menu.dashboard.shortcuts.background" = "${base0D}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.button_text" =
        "${base01}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.deny" =
        "${base08}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.confirm" =
        "${base0B}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.body" =
        "${base05}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.label" =
        "${base07}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.border" =
        "${base02}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.background" =
        "${base01}";
      "theme.bar.menus.menu.dashboard.powermenu.confirmation.card" =
        "${base00}";
      "theme.bar.menus.menu.dashboard.powermenu.sleep" = "${base0C}";
      "theme.bar.menus.menu.dashboard.powermenu.logout" = "${base0B}";
      "theme.bar.menus.menu.dashboard.powermenu.restart" = "${base09}";
      "theme.bar.menus.menu.dashboard.powermenu.shutdown" = "${base08}";
      "theme.bar.menus.menu.dashboard.profile.name" = "${base06}";
      "theme.bar.menus.menu.dashboard.border.color" = "${base02}";
      "theme.bar.menus.menu.dashboard.background.color" = "${base01}";
      "theme.bar.menus.menu.dashboard.card.color" = "${base00}";
      "theme.bar.menus.menu.clock.weather.hourly.temperature" = "${base06}";
      "theme.bar.menus.menu.clock.weather.hourly.icon" = "${base06}";
      "theme.bar.menus.menu.clock.weather.hourly.time" = "${base06}";
      "theme.bar.menus.menu.clock.weather.thermometer.extremelycold" =
        "${base0C}";
      "theme.bar.menus.menu.clock.weather.thermometer.cold" = "${base0D}";
      "theme.bar.menus.menu.clock.weather.thermometer.moderate" = "${base07}";
      "theme.bar.menus.menu.clock.weather.thermometer.hot" = "${base09}";
      "theme.bar.menus.menu.clock.weather.thermometer.extremelyhot" =
        "${base08}";
      "theme.bar.menus.menu.clock.weather.stats" = "${base06}";
      "theme.bar.menus.menu.clock.weather.status" = "${base0C}";
      "theme.bar.menus.menu.clock.weather.temperature" = "${base05}";
      "theme.bar.menus.menu.clock.weather.icon" = "${base06}";
      "theme.bar.menus.menu.clock.calendar.contextdays" = "${base04}";
      "theme.bar.menus.menu.clock.calendar.days" = "${base05}";
      "theme.bar.menus.menu.clock.calendar.currentday" = "${base06}";
      "theme.bar.menus.menu.clock.calendar.paginator" = "${base0F}";
      "theme.bar.menus.menu.clock.calendar.weekdays" = "${base06}";
      "theme.bar.menus.menu.clock.calendar.yearmonth" = "${base0C}";
      "theme.bar.menus.menu.clock.time.timeperiod" = "${base0C}";
      "theme.bar.menus.menu.clock.time.time" = "${base06}";
      "theme.bar.menus.menu.clock.text" = "${base05}";
      "theme.bar.menus.menu.clock.border.color" = "${base02}";
      "theme.bar.menus.menu.clock.background.color" = "${base01}";
      "theme.bar.menus.menu.clock.card.color" = "${base00}";
      "theme.bar.menus.menu.battery.slider.puck" = "${base04}";
      "theme.bar.menus.menu.battery.slider.backgroundhover" = "${base03}";
      "theme.bar.menus.menu.battery.slider.background" = "${base03}";
      "theme.bar.menus.menu.battery.slider.primary" = "${base0A}";
      "theme.bar.menus.menu.battery.icons.active" = "${base0A}";
      "theme.bar.menus.menu.battery.icons.passive" = "${base04}";
      "theme.bar.menus.menu.battery.listitems.active" = "${base0A}";
      "theme.bar.menus.menu.battery.listitems.passive" = "${base05}";
      "theme.bar.menus.menu.battery.text" = "${base05}";
      "theme.bar.menus.menu.battery.label.color" = "${base0A}";
      "theme.bar.menus.menu.battery.border.color" = "${base02}";
      "theme.bar.menus.menu.battery.background.color" = "${base01}";
      "theme.bar.menus.menu.battery.card.color" = "${base00}";
      "theme.bar.menus.menu.systray.dropdownmenu.divider" = "${base00}";
      "theme.bar.menus.menu.systray.dropdownmenu.text" = "${base05}";
      "theme.bar.menus.menu.systray.dropdownmenu.background" = "${base01}";
      "theme.bar.menus.menu.bluetooth.iconbutton.active" = "${base0C}";
      "theme.bar.menus.menu.bluetooth.iconbutton.passive" = "${base05}";
      "theme.bar.menus.menu.bluetooth.icons.active" = "${base0C}";
      "theme.bar.menus.menu.bluetooth.icons.passive" = "${base04}";
      "theme.bar.menus.menu.bluetooth.listitems.active" = "${base0C}";
      "theme.bar.menus.menu.bluetooth.listitems.passive" = "${base05}";
      "theme.bar.menus.menu.bluetooth.switch.puck" = "${base04}";
      "theme.bar.menus.menu.bluetooth.switch.disabled" = "${base04}";
      "theme.bar.menus.menu.bluetooth.switch.enabled" = "${base0C}";
      "theme.bar.menus.menu.bluetooth.switch_divider" = "${base03}";
      "theme.bar.menus.menu.bluetooth.status" = "${base04}";
      "theme.bar.menus.menu.bluetooth.text" = "${base05}";
      "theme.bar.menus.menu.bluetooth.label.color" = "${base0C}";
      "theme.bar.menus.menu.bluetooth.scroller.color" = "${base0C}";
      "theme.bar.menus.menu.bluetooth.border.color" = "${base02}";
      "theme.bar.menus.menu.bluetooth.background.color" = "${base01}";
      "theme.bar.menus.menu.bluetooth.card.color" = "${base00}";
      "theme.bar.menus.menu.network.iconbuttons.active" = "${base0E}";
      "theme.bar.menus.menu.network.iconbuttons.passive" = "${base05}";
      "theme.bar.menus.menu.network.icons.active" = "${base0E}";
      "theme.bar.menus.menu.network.icons.passive" = "${base04}";
      "theme.bar.menus.menu.network.listitems.active" = "${base0E}";
      "theme.bar.menus.menu.network.listitems.passive" = "${base05}";
      "theme.bar.menus.menu.network.status.color" = "${base04}";
      "theme.bar.menus.menu.network.text" = "${base05}";
      "theme.bar.menus.menu.network.label.color" = "${base0E}";
      "theme.bar.menus.menu.network.scroller.color" = "${base0E}";
      "theme.bar.menus.menu.network.border.color" = "${base02}";
      "theme.bar.menus.menu.network.background.color" = "${base01}";
      "theme.bar.menus.menu.network.card.color" = "${base00}";
      "theme.bar.menus.menu.volume.input_slider.puck" = "${base04}";
      "theme.bar.menus.menu.volume.input_slider.backgroundhover" = "${base03}";
      "theme.bar.menus.menu.volume.input_slider.background" = "${base03}";
      "theme.bar.menus.menu.volume.input_slider.primary" = "${base0B}";
      "theme.bar.menus.menu.volume.audio_slider.puck" = "${base04}";
      "theme.bar.menus.menu.volume.audio_slider.backgroundhover" = "${base03}";
      "theme.bar.menus.menu.volume.audio_slider.background" = "${base03}";
      "theme.bar.menus.menu.volume.audio_slider.primary" = "${base0D}";
      "theme.bar.menus.menu.volume.icons.active" = "${base06}";
      "theme.bar.menus.menu.volume.icons.passive" = "${base04}";
      "theme.bar.menus.menu.volume.iconbutton.active" = "${base06}";
      "theme.bar.menus.menu.volume.iconbutton.passive" = "${base05}";
      "theme.bar.menus.menu.volume.listitems.active" = "${base0D}";
      "theme.bar.menus.menu.volume.listitems.passive" = "${base04}";
      "theme.bar.menus.menu.volume.text" = "${base05}";
      "theme.bar.menus.menu.volume.label.color" = "${base06}";
      "theme.bar.menus.menu.volume.border.color" = "${base02}";
      "theme.bar.menus.menu.volume.background.color" = "${base01}";
      "theme.bar.menus.menu.volume.card.color" = "${base00}";
      "theme.bar.menus.menu.media.slider.puck" = "${base04}";
      "theme.bar.menus.menu.media.slider.backgroundhover" = "${base03}";
      "theme.bar.menus.menu.media.slider.background" = "${base03}";
      "theme.bar.menus.menu.media.slider.primary" = "${base09}";
      "theme.bar.menus.menu.media.buttons.text" = "${base01}";
      "theme.bar.menus.menu.media.buttons.background" = "${base0D}";
      "theme.bar.menus.menu.media.buttons.enabled" = "${base0C}";
      "theme.bar.menus.menu.media.buttons.inactive" = "${base04}";
      "theme.bar.menus.menu.media.border.color" = "${base02}";
      "theme.bar.menus.menu.media.card.color" = "${base00}";
      "theme.bar.menus.menu.media.background.color" = "${base01}";
      "theme.bar.menus.menu.media.album" = "${base0F}";
      "theme.bar.menus.menu.media.timestamp" = "${base05}";
      "theme.bar.menus.menu.media.artist" = "${base0B}";
      "theme.bar.menus.menu.media.song" = "${base0D}";
      "theme.bar.menus.tooltip.text" = "${base05}";
      "theme.bar.menus.tooltip.background" = "${base01}";
      "theme.bar.menus.dropdownmenu.divider" = "${base00}";
      "theme.bar.menus.dropdownmenu.text" = "${base05}";
      "theme.bar.menus.dropdownmenu.background" = "${base01}";
      "theme.bar.menus.slider.puck" = "${base04}";
      "theme.bar.menus.slider.backgroundhover" = "${base03}";
      "theme.bar.menus.slider.background" = "${base02}";
      "theme.bar.menus.slider.primary" = "${base07}";
      "theme.bar.menus.progressbar.background" = "${base03}";
      "theme.bar.menus.progressbar.foreground" = "${base07}";
      "theme.bar.menus.iconbuttons.active" = "${base0D}";
      "theme.bar.menus.iconbuttons.passive" = "${base05}";
      "theme.bar.menus.buttons.text" = "${base01}";
      "theme.bar.menus.buttons.disabled" = "${base04}";
      "theme.bar.menus.buttons.active" = "${base0F}";
      "theme.bar.menus.buttons.default" = "${base07}";
      "theme.bar.menus.check_radio_button.active" = "${base0D}";
      "theme.bar.menus.check_radio_button.background" = "${base03}";
      "theme.bar.menus.switch.puck" = "${base04}";
      "theme.bar.menus.switch.disabled" = "${base03}";
      "theme.bar.menus.switch.enabled" = "${base07}";
      "theme.bar.menus.icons.active" = "${base07}";
      "theme.bar.menus.icons.passive" = "${base04}";
      "theme.bar.menus.listitems.active" = "${base0D}";
      "theme.bar.menus.listitems.passive" = "${base05}";
      "theme.bar.menus.popover.border" = "${base01}";
      "theme.bar.menus.popover.background" = "${base01}";
      "theme.bar.menus.popover.text" = "${base07}";
      "theme.bar.menus.label" = "${base07}";
      "theme.bar.menus.feinttext" = "${base02}";
      "theme.bar.menus.dimtext" = "${base04}";
      "theme.bar.menus.text" = "${base05}";
      "theme.bar.menus.border.color" = "${base02}";
      "theme.bar.menus.cards" = "${base00}";
      "theme.bar.menus.background" = "${base01}";
      "theme.bar.buttons.modules.power.icon_background" = "${base08}";
      "theme.bar.buttons.modules.power.icon" = "${base08}";
      "theme.bar.buttons.modules.power.background" = "${base00}";
      "theme.bar.buttons.modules.power.border" = "${base08}";
      "theme.bar.buttons.modules.weather.icon_background" = "${base07}";
      "theme.bar.buttons.modules.weather.icon" = "${base07}";
      "theme.bar.buttons.modules.weather.text" = "${base07}";
      "theme.bar.buttons.modules.weather.background" = "${base00}";
      "theme.bar.buttons.modules.weather.border" = "${base07}";
      "theme.bar.buttons.modules.updates.icon_background" = "${base0E}";
      "theme.bar.buttons.modules.updates.icon" = "${base0E}";
      "theme.bar.buttons.modules.updates.text" = "${base0E}";
      "theme.bar.buttons.modules.updates.background" = "${base00}";
      "theme.bar.buttons.modules.updates.border" = "${base0E}";
      "theme.bar.buttons.modules.kbLayout.icon_background" = "${base0C}";
      "theme.bar.buttons.modules.kbLayout.icon" = "${base0C}";
      "theme.bar.buttons.modules.kbLayout.text" = "${base0C}";
      "theme.bar.buttons.modules.kbLayout.background" = "${base00}";
      "theme.bar.buttons.modules.kbLayout.border" = "${base0C}";
      "theme.bar.buttons.modules.netstat.icon_background" = "${base0B}";
      "theme.bar.buttons.modules.netstat.icon" = "${base0B}";
      "theme.bar.buttons.modules.netstat.text" = "${base0B}";
      "theme.bar.buttons.modules.netstat.background" = "${base00}";
      "theme.bar.buttons.modules.netstat.border" = "${base0B}";
      "theme.bar.buttons.modules.storage.icon_background" = "${base06}";
      "theme.bar.buttons.modules.storage.icon" = "${base06}";
      "theme.bar.buttons.modules.storage.text" = "${base06}";
      "theme.bar.buttons.modules.storage.background" = "${base00}";
      "theme.bar.buttons.modules.storage.border" = "${base06}";
      "theme.bar.buttons.modules.cpu.icon_background" = "${base08}";
      "theme.bar.buttons.modules.cpu.icon" = "${base08}";
      "theme.bar.buttons.modules.cpu.text" = "${base08}";
      "theme.bar.buttons.modules.cpu.background" = "${base00}";
      "theme.bar.buttons.modules.cpu.border" = "${base08}";
      "theme.bar.buttons.modules.ram.icon_background" = "${base0A}";
      "theme.bar.buttons.modules.ram.icon" = "${base0A}";
      "theme.bar.buttons.modules.ram.text" = "${base0A}";
      "theme.bar.buttons.modules.ram.background" = "${base00}";
      "theme.bar.buttons.modules.ram.border" = "${base0A}";
      "theme.bar.buttons.notifications.total" = "${base07}";
      "theme.bar.buttons.notifications.icon_background" = "${base07}";
      "theme.bar.buttons.notifications.icon" = "${base0B}";
      "theme.bar.buttons.notifications.background" = "${base00}";
      "theme.bar.buttons.notifications.border" = "${base07}";
      "theme.bar.buttons.clock.icon_background" = "${base06}";
      "theme.bar.buttons.clock.icon" = "${base0B}";
      "theme.bar.buttons.clock.text" = "${base0B}";
      "theme.bar.buttons.clock.background" = "${base00}";
      "theme.bar.buttons.clock.border" = "${base06}";
      "theme.bar.buttons.battery.icon_background" = "${base0A}";
      "theme.bar.buttons.battery.icon" = "${base0A}";
      "theme.bar.buttons.battery.text" = "${base0A}";
      "theme.bar.buttons.battery.background" = "${base00}";
      "theme.bar.buttons.battery.border" = "${base0A}";
      "theme.bar.buttons.systray.background" = "${base00}";
      "theme.bar.buttons.systray.border" = "${base07}";
      "theme.bar.buttons.systray.customIcon" = "${base05}";
      "theme.bar.buttons.bluetooth.icon_background" = "${base0C}";
      "theme.bar.buttons.bluetooth.icon" = "${base0C}";
      "theme.bar.buttons.bluetooth.text" = "${base0C}";
      "theme.bar.buttons.bluetooth.background" = "${base00}";
      "theme.bar.buttons.bluetooth.border" = "${base0C}";
      "theme.bar.buttons.network.icon_background" = "${base0E}";
      "theme.bar.buttons.network.icon" = "${base0E}";
      "theme.bar.buttons.network.text" = "${base0E}";
      "theme.bar.buttons.network.background" = "${base00}";
      "theme.bar.buttons.network.border" = "${base0E}";
      "theme.bar.buttons.volume.icon_background" = "${base09}";
      "theme.bar.buttons.volume.icon" = "${base09}";
      "theme.bar.buttons.volume.text" = "${base09}";
      "theme.bar.buttons.volume.background" = "${base00}";
      "theme.bar.buttons.volume.border" = "${base09}";
      "theme.bar.buttons.media.icon_background" = "${base07}";
      "theme.bar.buttons.media.icon" = "${base08}";
      "theme.bar.buttons.media.text" = "${base08}";
      "theme.bar.buttons.media.background" = "${base00}";
      "theme.bar.buttons.media.border" = "${base07}";
      "theme.bar.buttons.windowtitle.icon_background" = "${base06}";
      "theme.bar.buttons.windowtitle.icon" = "${base06}";
      "theme.bar.buttons.windowtitle.text" = "${base06}";
      "theme.bar.buttons.windowtitle.border" = "${base06}";
      "theme.bar.buttons.windowtitle.background" = "${base00}";
      "theme.bar.buttons.workspaces.numbered_active_underline_color" =
        "${base0B}";
      "theme.bar.buttons.workspaces.numbered_active_highlighted_text_color" =
        "${base01}";
      "theme.bar.buttons.workspaces.hover" = "${base0D}";
      "theme.bar.buttons.workspaces.active" = "${base0B}";
      "theme.bar.buttons.workspaces.occupied" = "${base0F}";
      "theme.bar.buttons.workspaces.available" = "${base0C}";
      "theme.bar.buttons.workspaces.border" = "${base06}";
      "theme.bar.buttons.workspaces.background" = "${base00}";
      "theme.bar.buttons.dashboard.icon" = "${base0A}";
      "theme.bar.buttons.dashboard.border" = "${base0A}";
      "theme.bar.buttons.dashboard.background" = "${base00}";
      "theme.bar.buttons.icon" = "${base07}";
      "theme.bar.buttons.text" = "${base07}";
      "theme.bar.buttons.hover" = "${base03}";
      "theme.bar.buttons.icon_background" = "${base00}";
      "theme.bar.buttons.background" = "${base00}";
      "theme.bar.buttons.borderColor" = "${base07}";
      "theme.bar.buttons.style" = "default";
      "theme.bar.background" = "${base01}";
      "theme.osd.label" = "${base0D}";
      "theme.osd.icon" = "${base01}";
      "theme.osd.bar_overflow_color" = "${base08}";
      "theme.osd.bar_empty_color" = "${base02}";
      "theme.osd.bar_color" = "${base0D}";
      "theme.osd.icon_container" = "${base0D}";
      "theme.osd.bar_container" = "${base01}";
      "theme.notification.close_button.label" = "${base01}";
      "theme.notification.close_button.background" = "${base08}";
      "theme.notification.labelicon" = "${base07}";
      "theme.notification.text" = "${base05}";
      "theme.notification.time" = "${base04}";
      "theme.notification.border" = "${base03}";
      "theme.notification.label" = "${base07}";
      "theme.notification.actions.text" = "${base01}";
      "theme.notification.actions.background" = "${base0D}";
      "theme.notification.background" = "${base01}";
      "theme.bar.buttons.modules.submap.icon" = "${base0C}";
      "theme.bar.buttons.modules.submap.background" = "${base00}";
      "theme.bar.buttons.modules.submap.icon_background" = "${base00}";
      "theme.bar.buttons.modules.submap.text" = "${base0C}";
      "theme.bar.buttons.modules.submap.border" = "${base0C}";
      "theme.bar.menus.menu.network.switch.enabled" = "${base0E}";
      "theme.bar.menus.menu.network.switch.disabled" = "${base04}";
      "theme.bar.menus.menu.network.switch.puck" = "${base04}";
      "theme.bar.border.color" = "${base07}";
      "theme.bar.buttons.modules.hyprsunset.icon" = "${base09}";
      "theme.bar.buttons.modules.hyprsunset.background" = "${base00}";
      "theme.bar.buttons.modules.hyprsunset.icon_background" = "${base00}";
      "theme.bar.buttons.modules.hyprsunset.text" = "${base09}";
      "theme.bar.buttons.modules.hyprsunset.border" = "${base06}";
      "theme.bar.buttons.modules.hypridle.icon" = "${base0C}";
      "theme.bar.buttons.modules.hypridle.background" = "${base00}";
      "theme.bar.buttons.modules.hypridle.icon_background" = "${base06}";
      "theme.bar.buttons.modules.hypridle.text" = "${base06}";
      "theme.bar.buttons.modules.hypridle.border" = "${base06}";
      "theme.bar.buttons.modules.cava.text" = "${base0C}";
      "theme.bar.buttons.modules.cava.background" = "${base00}";
      "theme.bar.buttons.modules.cava.icon_background" = "${base00}";
      "theme.bar.buttons.modules.cava.icon" = "${base0C}";
      "theme.bar.buttons.modules.cava.border" = "${base0C}";
      "theme.bar.buttons.modules.worldclock.text" = "${base08}";
      "theme.bar.buttons.modules.worldclock.background" = "${base00}";
      "theme.bar.buttons.modules.worldclock.icon_background" = "${base06}";
      "theme.bar.buttons.modules.worldclock.icon" = "${base06}";
      "theme.bar.buttons.modules.worldclock.border" = "${base06}";
      "theme.bar.buttons.modules.microphone.border" = "${base0B}";
      "theme.bar.buttons.modules.microphone.background" = "${base00}";
      "theme.bar.buttons.modules.microphone.text" = "${base0B}";
      "theme.bar.buttons.modules.microphone.icon" = "${base0B}";
      "theme.bar.buttons.modules.microphone.icon_background" = "${base00}";
    };

  };

}
