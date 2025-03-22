{ pkgs, lib, config, ... }:

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
          #   "1"= "";
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
        media = { middleClick = "playerctl play-pause"; };
      };

      # Settings for the dropdown menus themselves
      menus = {
        # Settings for dashboard menu
        dashboard = {

          powermenu.avatar.image = "${config.home.homeDirectory}/nix/configs/users/${config.home.username}/configs/profile.png";

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
          # Shortcut buttons
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
      };
    };
  };

}
