{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = { gtk = true; };
    config = rec {

      # Use Windows key for mod
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty";

      fonts = {
        names = [ config.stylix.fonts.monospace.name ];
        #style = "Regular";
        size = config.stylix.fonts.sizes.desktop + 0.0;
      };

      # Configure outputs
      output = {
        # For VM
        Virtual-1 = { mode = "1920x1080@60.000Hz"; };
      };

      #colors = {
      #	focused = {
      #		# Set text color for focused windows
      #		text = "${base0B}";
      #	};
      #};

      seat = {
        # Inherit the globally set cursor theme
        seat0 = {
          xcursor_theme = "${config.home.pointerCursor.name} ${
              toString config.home.pointerCursor.size
            }";
        };
      };

      gaps = {
        vertical = 4;
        top = 4;
        bottom = 4;
        inner = 4;
        outer = 4;
        left = 4;
        right = 4;
        smartGaps = false;
        smartBorders = "off"; # off on or no_gaps
      };

      # Special configs for specific windows
      window = {
        commands = [

          # Set the translate window to always be floating and in the scratchpad
          {
            command =
              "floating enable, resize set 200 300, move scratchpad, move position 15 15;";
            criteria = { app_id = "translate"; };
          }

          # Set the calculator window to always be floating and in the scratchpad
          {
            command =
              "floating enable, resize set 300 300, move scratchpad, move position 15 15;";
            criteria = { app_id = "calculator"; };
          }
          # Set the calculator window to always be floating and in the scratchpad
          {
            command =
              "floating enable, resize set 300 300, move scratchpad, move position 15 15;";
            criteria = { app_id = "calendar"; };
          }
        ];
      };

      # Startup Commands
      startup = [
        # Launch Notification client on start
        {
          command = "mako";
        }
        # Apply colorscheme
        #{command = "wal -R";}
        # Launch Waybar
        {
          command = "waybar";
        }
        # Start translate window
        {
          command =
            "${pkgs.kitty}/bin/kitty --class translate --title translate trans -theme random -I";
        }
        # Start calculator
        {
          command =
            "${pkgs.kitty}/bin/kitty --class calculator --title calculator qalc";
        }
        # Start calculator
        {
          command =
            "${pkgs.kitty}/bin/kitty --class calendar --title calendar khal interactive";
        }
      ];

      menu = "wofi --show run";

      # if you move to one ws, tap the same number to return to last ws
      workspaceAutoBackAndForth = true;

      # Set to empty since we use waybar
      bars = [ ];

      keybindings =
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Shift+q" = "kill";
          #"${modifier}+Shift+x" = "exec swaylock";
          "${modifier}+Shift+x" =
            "exec ${config.home.homeDirectory}/nix/configs/modules/scripts/user/desktop/power/lock.sh";
          "${modifier}+Shift+f" = "fullscreen toggle";
          "${modifier}+Shift+s" = "layout stacking";
          "${modifier}+Shift+w" = "layout tabbed";
          "${modifier}+Shift+e" = "layout toggle split";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+e" = "exec wofi-emoji";
          "${modifier}+t" =
            "exec swaymsg [app_id='translate'] scratchpad show"; # HACK not sure why I need to exec swaymsg on this one
          "${modifier}+c" =
            "exec swaymsg [app_id='calendar'] scratchpad show"; # HACK not sure why I need to exec swaymsg on this one
          "${modifier}+m" =
            "exec swaymsg [app_id='calculator'] scratchpad show"; # HACK not sure why I need to exec swaymsg on this one
          "${modifier}+p" =
            "exec ${config.home.homeDirectory}/nix/configs/modules/scripts/user/desktop/navigation/sway-window-switcher.sh";
          "${modifier}+s" =
            "exec ${config.home.homeDirectory}/nix/configs/modules/scripts/user/desktop/search/wofi-web-search.sh";
          #TODO awk doesn't actually output anything
          "${modifier}+f" =
            "exec cat ${config.home.homeDirectory}/nix/configs/modules/configs/user/wofi/lists/french.csv | wofi --dmenu | awk '{print $1}'";
        };

    };
  };

}
