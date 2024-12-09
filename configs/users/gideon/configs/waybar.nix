{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.waybar = {
    enable = true;

    # TODO finish styling
    # General colors are provided by stylix, these are overrides
    # This gets concatenated to ~/.config/waybar/style.css
    # this means we have access to @ vars from that css file
    #.modules-left #workspaces button.focused,
    #.modules-left #workspaces button.active {
    style = ''
      .modules-left #workspaces button {
      	color: @base05;
      }
      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active {
      	border-bottom: 3px solid @base08;
      	color: @base0A;
      }
      .modules-center #clock {
      	color: @base06
      }
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        #TODO configure these dynamically with zanshin
        #output = [
        #"eDP-1"
        #"HDMI-A-1"
        #];
        modules-left = [
          "group/systemMenu"
          # "sway/workspaces"
          # "sway/mode"
          "hyprland/workspaces"
          "hyprland/window"
          #"hyprland/submap"
        ];
        modules-center = [
          #"sway/window"
          "clock"
        ];
        modules-right = [
          "group/screenCapture"
          "group/systemStats"
          "backlight/slider"
          "network"
          "battery"
          #"cava"
          "custom/mako"
          "wireplumber"
          "mpris"
          #"bluetooth"
          "custom/weather"
          "tray"
        ];

        "idle_inhibitor" = {
          format = "{icon}";
          tooltip = true;
          tooltip-format-activated = "Screen Locking Disabled";
          tooltip-format-deactivated = "Screen Locking Enabled ";
          "format-icons" = {
            # Save these for another toggle
            #"activated": "",
            #"deactivated": ""
            activated = "<span color='${base08}'></span>";
            deactivated = "<span color='${base0B}'></span>";
          };
        };

        "custom/poweroff" = {
          format = "<span color='${base08}'>  </span>";
          on-click =
            "$HOME/nix/configs/users/gideon/scripts/system/power/poweroff.sh";
          #tooltip = true;
          tooltip-format = "<span color='${base08}'>Power Off </span>";
        };
        "custom/reboot" = {
          format = "<span color='${base09}'>  </span>";
          on-click =
            "$HOME/nix/configs/users/gideon/scripts/system/power/reboot.sh";
          tooltip-format = "<span color='${base09}'>Reboot</span>";
        };
        "custom/logout" = {
          format = "<span color='${base0A}'>  </span>";
          on-click = "swaymsg exit";
          tooltip-format = "<span color='${base0A}'>Logout</span>";
        };
        "custom/suspend" = {
          format = "<span color='${base0D}'>  </span>";
          on-click =
            "$HOME/nix/configs/users/gideon/scripts/system/power/suspend.sh";
          tooltip-format = "<span color='${base0D}'>Suspend</span>";
        };

        "network" = {
          # TODO icons and info with color codes
          format = " {ifname}";
          format-wifi = "<span color='${base0E}'> </span>";
          format-ethernet = "<span color='${base0E}'></span>";
          format-disconnected =
            "<span color='${base08}'> </span>"; # An empty format will hide the module.
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          #tooltip-format-wifi = " {essid} \n {ipaddr}/{cidr} \n {signalStrength}% Strength \n {bandwidthUpBits} \n {bandwidthDownBits}";
          #tooltip-format-ethernet = "{ifname} \n{ipaddr}/{cidr} \n {bandwidthUpBits} \n {bandwidthDownBits}";
          #TODO this is neater but adds a ton of whitespace
          # The whitespace disappears when this text is left aligned but its UGLY
          tooltip-format-ethernet = [
            "<span color='${base0E}'></span>{ifname}"
            "<span color='${base0E}'></span>{ipaddr}/{cidr}"
            "<span color='${base0E}'> </span>{bandwidthUpBits}"
            "<span color='${base0E}'> </span>{bandwidthDownBits}"
          ];
          tooltip-format-wifi = [
            "<span color='${base0E}'> </span>{essid}"
            "<span color='${base0E}'></span>{ipaddr}/{cidr}"
            "<span color='${base0E}'> </span>{signalStrength}"
            "<span color='${base0E}'> </span>{bandwidthUpBits}"
            "<span color='${base0E}'> </span>{bandwidthDownBits}"
          ];
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nm-connection-editor";
        };

        "bluetooth" = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery =
            " {device_alias} {device_battery_percentage}%";
          #format-device-preference = [ "device1", "device2" ]; preference list deciding the displayed device
          tooltip-format = ''
            {controller_alias}	{controller_address}

            {num_connections} connected'';
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected =
            "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery =
            "{device_alias}	{device_address}	{device_battery_percentage}%";
        };

        # Group of commonly used controls for the system
        "group/systemMenu" = {
          orientation = "horizontal";
          modules = [
            "custom/systemMenuIcon"
            "custom/poweroff"
            "custom/reboot"
            "custom/suspend"
            "custom/logout"
            "idle_inhibitor"
          ];
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
            children-class = "systemMenu";
          };
        };
        "custom/systemMenuIcon" = {
          format = "<span color='${base0E}'><b> </b></span>";
          tooltip = false;
        };
        # Commonly requested stats on system
        "group/systemStats" = {
          orientation = "horizontal";
          modules = [ "cpu" "memory" "disk" "temperature" ];
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
            children-class = "systemStats";
          };
        };
        # Menu to capture screen with image and video
        "group/screenCapture" = {
          orientation = "horizontal";
          modules = [ "custom/screenshot" "custom/screen_recorder" ];
          drawer = {
            transition-duration = 500;
            transition-left-to-right = false;
            children-class = "screenCapture";
          };
        };
        "disk" = {
          format = "<span color='${base0E}'> </span>{percentage_used}%";
          on-click = "baobab /";
          on-click-middle = "alacritty --command diskonaut /";
          on-click-right = "alacritty --command sudo iotop";
        };

        "temperature" = {
          format = "{icon} {temperatureC}";
          format-icons = [
            "<span color='${base0D}'></span>"
            "<span color='${base0B}'></span>"
            "<span color='${base0A}'></span>"
            "<span color='${base09}'></span>"
            "<span color='${base08}'></span>"
          ];
          on-click = "psensor";
        };
        "memory" = {
          format = "<span color='${base0A}'></span>{percentage}%";
          on-click = "alacritty --command NMON=m nmon";
        };
        "cpu" = {
          format = "{icon}{usage}%";
          #format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          format-icons = [
            "<span color='${base0B}'> </span>"
            "<span color='${base0A}'> </span>"
            "<span color='${base09}'> </span>"
            "<span color='${base08}'> </span>"
          ];
          on-click = "sudo cpupower-gui";
          on-click-right = "hardinfo";
        };
        "battery" = {
          format = "{icon} {capacity}%";
          tooltip = true;
          format-icons = [
            # These colors may need to be reversed
            "<span color='${base08}'></span>"
            "<span color='${base09}'></span>"
            "<span color='${base0A}'></span>"
            "<span color='${base0B}'></span>"
            "<span color='${base0D}'></span>"
          ];
          # This should add an arrow to icon when charging
          format-charging = [
            "<span color='${base08}'> </span>"
            "<span color='${base09}'> </span>"
            "<span color='${base0A}'> </span>"
            "<span color='${base0B}'> </span>"
            "<span color='${base0D}'> </span>"
          ];
          tooltip-format-charging = ''
            Current Charge: {capacity}%
            Current Draw: {power} Watts
            Time Left: {time}
          '';
          on-click = "sudo powertop";
        };

        "wireplumber" = {
          format = "{icon} {volume}%";
          on-click-middle = "qpwgraph";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          format-muted = "<span color='${base08}'> {volume}%</span>";
          #format-icons = [ "" "" ""];
          format-icons = [
            "<span color='${base0D}'></span>"
            "<span color='${base0B}'></span>"
            "<span color='${base0A}'></span> "
            "<span color='${base08}'></span> "
          ];
        };

        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          exec =
            "wttrbar --main-indicator temp_F --fahrenheit --mph --location New_York";
          return-type = "json";
        };
        "custom/screenshot" = {
          format = "<span color='${base0C}'> </span>";
          tooltip = true;
          tooltip-format = "Screenshot";
          on-click = "flameshot gui";
        };

        "custom/screen_recorder" = {
          tooltip = true;
          interval = 1;
          format = "<span color='${base0D}'>{} </span>";
          exec =
            "$HOME/nix/configs/users/gideon/scripts/system/screen-capture/screen-recorder.sh status";
          on-click-middle =
            "$HOME/nix/configs/users/gideon/scripts/system/screen-capture/screen-recorder.sh toggle display";
          on-click-left =
            "$HOME/nix/configs/user/gideon/scripts/system/screen-capture/screen-recorder.sh toggle region";
          on-click-right =
            "$HOME/nix/configs/user/gideon/scripts/system/screen-capture/screen-recorder.sh toggle fullscreen";
          return-type = "json";
        };

        "custom/mako" = {
          tooltip = true;
          interval = 1;
          format = "<span color='${base0D}'>{} </span>";
          exec =
            "$HOME/nix/configs/users/gideon/scripts/system/notifications/mako-toggle-waybar.sh status";
          on-click-left =
            "$HOME/nix/configs/users/gideon/scripts/system/notifications/mako-toggle-waybar.sh toggle";
          on-click-right =
            "$HOME/nix/configs/users/gideon/scripts/system/notifications/mako-toggle-waybar.sh toggle";
          return-type = "json";
          signal = 8;
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          # Workspace Icons
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            # TODO this works for color but can't reference icon
            # I think waybar exposes CSS for it
            #"focused" = "<span color='#FFFFFF'>{icon}</span>";
            #"urgent" = "";
            #"default" = "";
          };
        };

        "mpris" = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
            firefox = "";
            #vlc = "";
          };
          status-icons = {
            paused = "⏸";
            playing = "▶";
          };
          # ignored-players = [firefox];
        };

        "cava" = {
          method = "pipewire";
          framerate = 80;
          sensitivity = 1;
          bars = 7;
          bar_delimiter = 0; # 0=none
          autosens = 1;
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          sleep_timer = 10;
          hide_on_silence = true;
          monstercat = true;
          waves = true;

        };

        "clock" = {
          interval = 60;
          tooltip = true;
          format = "{:%H:%M}";
          #TODO this should work but I don't think stylix-23.11 has lib.stylix?
          #format = "<span color=${lib.stylix.colors.withHashtag.base04}>{:%H:%M}</span>";
          # long date on hover
          #tooltip-format = "{:%Y-%m-%d}";

          # calendar on hover
          tooltip-format = ''

            <span size='9pt' font='Hack Nerd Font Mono'>{calendar}</span>'';

          # Calendar Settings
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            week-pos = "right";
            on-scroll = 1;

            # Calendar Format
            format = {
              months = "<span color='${base0D}'><b>{}</b></span>";
              days = "<span color='${base05}'><b>{}</b></span>";
              weeks = "<span color='${base0B}'><b>W{}</b></span>";
              weekdays = "<span color='${base0C}'><b>{}</b></span>";
              today = "<span color='${base08}'><b><u>{}</u></b></span>";
            };
          };

          # Widget Actions
          actions = {
            on-click-right = "mode";
            #on-click-forward = "tz_up";
            #on-click-backward = "tz_down";
            #on-scroll-up = "shift_up";
            #on-scroll-down = "shift_down";
          };
        };
      };
    };
  };
}
