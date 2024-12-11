{ pkgs, lib, inputs, config, ... }:

with config.lib.stylix.colors;

{

  wayland.windowManager.hyprland = {
    # allow home manager to configure hyprland	
    enable = true;

    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$menu" = "pkill wofi || wofi --show run";

      bindm = [
        #"$mod, Return, exec, kitty"
        #"$mod Shift, F, fullscreen"
        "$mod Shift, Q, killactive"
      ];

      group = {
        #col.border_active = "rgb(${base0D})";
        #col.border_inactive = "rgb(${base00})";
        groupbar = {
          font_size = config.stylix.fonts.sizes.desktop;
          text_color = "rgb(${base05})";
          #col.active = "rgb(${base0D})";
          #col.inactive = "rgb(${base00})";
          #col.locked_active = "rgb(${base0D})";
          #col.locked_inactive = "rgb(${base00})";
        };
      };

    };
    extraConfig = ''
      #exec = pkill waybar & sleep 0.5 && waybar
      #exec-once = hyprpanel

      monitor=,preferred,auto,1

      # fixes scaling issue (stuff was too big)
      xwayland {
          force_zero_scaling = true
      }

      bind = $mod, RETURN, exec, kitty
      bind = $mod SHIFT, Q, killactive
      #bind = $mod SHIFT, F, fullscreen
      bind = $mod SHIFT, F, fullscreen, 2
      bind = $mod, M, exit,
      bind = $mod SHIFT, P, exec, ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/nix/configs/users/gideon/scripts/system/navigation/hyprland-window-switcher.sh,
      bind = $mod SHIFT, G, togglegroup,
      bind = $mod, G, changegroupactive,
      bind = $mod, V, togglefloating,
      bind = $mod, D, exec, $menu
      bind = $mod, P, pseudo, # dwindle
      bind = $mod, J, togglesplit, # dwindle

      # Move focus with mod + arrow keys
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d
      # vim bindings
      bind = $mod, h, movefocus, l
      bind = $mod, l, movefocus, r
      bind = $mod, k, movefocus, u
      bind = $mod, j, movefocus, d

      bind = $mod SHIFT, Left, movewindow, l
      bind = $mod SHIFT, Right, movewindow, r
      bind = $mod SHIFT, Up, movewindow, u
      bind = $mod SHIFT, Down, movewindow, d
      bind = $mod SHIFT, h, movewindow, l
      bind = $mod SHIFT, l, movewindow, r
      bind = $mod SHIFT, k, movewindow, u
      bind = $mod SHIFT, j, movewindow, d

      # Switch workspaces with mod + [0-9]
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9
      bind = $mod, 0, workspace, 10

      # Move active window to a workspace with mod + SHIFT + [0-9]
      bind = $mod SHIFT, 1, movetoworkspace, 1
      bind = $mod SHIFT, 2, movetoworkspace, 2
      bind = $mod SHIFT, 3, movetoworkspace, 3
      bind = $mod SHIFT, 4, movetoworkspace, 4
      bind = $mod SHIFT, 5, movetoworkspace, 5
      bind = $mod SHIFT, 6, movetoworkspace, 6
      bind = $mod SHIFT, 7, movetoworkspace, 7
      bind = $mod SHIFT, 8, movetoworkspace, 8
      bind = $mod SHIFT, 9, movetoworkspace, 9
      bind = $mod SHIFT, 0, movetoworkspace, 10

      # Volume/media binds
      bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      # Requires playerctl
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindl = , XF86AudioNext, exec, playerctl next
      # Brightness
      bindel = ,XF86MonBrightnessDown, exec, sudo /run/current-system/sw/bin/light -U 10
      bindel = ,XF86MonBrightnessUp, exec, sudo /run/current-system/sw/bin/light -A 10

      group {
        col.border_active = "rgb(${base0D}) rgb(${base0D})";
        col.border_inactive = "rgb(${base00}) rgb(${base00})";

        groupbar {
          col.active = "rgb(${base0D})";
          col.inactive = "rgb(${base00})";
        }
      }

    '';

    # BUG: https://github.com/hyprwm/hyprland-plugins/issues/193
    # plugins = [
    #   inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprtrails
    #   #inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
    # ];
    #
  };
}
