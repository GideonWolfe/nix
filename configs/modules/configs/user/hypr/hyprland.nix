{ pkgs, lib, inputs, config, ... }:

with config.lib.stylix.colors;

{

  wayland.windowManager.hyprland = {
    # allow home manager to configure hyprland	
    enable = true;

    #package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    systemd.enable = true;

    settings = {

      # Set Windows key as mod key
      "$mod" = "SUPER";

      # reference var for launching our menu
      "$menu" = "pkill wofi || wofi --show run";

      # Commands that will get executed on login
      exec-once = [
        # Start HyprPanel
        "hyprpanel"

        # Or start waybar
        #"pkill waybar & sleep 0.5 && waybar"

        # Start Kando
        "kando"

        # Set the correct cursor
        "hyprctl setcursor ${config.home.pointerCursor.name} ${
          builtins.toString (config.home.pointerCursor.size + 8)
        }"
      ];

      # Mouse bindings
      bindm = [
        # mod+left click to move window
        "$mod, mouse:272, movewindow"
        # mod+right click to resize window
        "$mod, mouse:273, resizewindow"
      ];

      # e means it can get "held"
      # l means it works on the lockscreen
      bindel = [
        # Raise volume key or volume wheel
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
        # Lower volume key or volume wheel
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
        # Brightness buttons
        ",XF86MonBrightnessDown, exec, sudo /run/current-system/sw/bin/light -U 10"
        ",XF86MonBrightnessUp, exec, sudo /run/current-system/sw/bin/light -A 10"
      ];

      # l means it works on the lockscreen
      bindl = [
        # Mute key toggle
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        # Mute Mic key toggle
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # Play/Pause button
        ", XF86AudioPlay, exec, playerctl play-pause"
        # Previous button
        ", XF86AudioPrev, exec, playerctl previous"
        # Next button
        ", XF86AudioNext, exec, playerctl next"

        # Hyprlock when the lid is closed
        ",switch:on:Lid Switch, exec, hyprctl dispatch exec hyprlock && systemctl suspend"
      ];

      # Key bindings
      bind = [

        # Open terminal
        "$mod, RETURN, exec, kitty"
        # Close active window
        "$mod SHIFT, Q, killactive"
        # Toggle fullscreen on active window
        "$mod SHIFT, F, fullscreen, 2"
        # Toggle floating on active window
        "$mod, V, togglefloating,"

        # Toggle group for the window
        "$mod SHIFT, G, togglegroup,"
        # Cycle windows within a group
        "$mod, G, changegroupactive,"

        # Move focus with arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # Move focus with vim keybinds
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # mod+shift+direction moves windows
        "$mod SHIFT, Left, movewindoworgroup, l"
        "$mod SHIFT, Right, movewindoworgroup, r"
        "$mod SHIFT, Up, movewindoworgroup, u"
        "$mod SHIFT, Down, movewindoworgroup, d"
        "$mod SHIFT, h, movewindoworgroup, l"
        "$mod SHIFT, l, movewindoworgroup, r"
        "$mod SHIFT, k, movewindoworgroup, u"
        "$mod SHIFT, j, movewindoworgroup, d"

        # Switch workspaces with mod+<number>
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Menus
        # Kando desktop menu
        "CTRL, Space, global, kando:desktop-menu"
        # Execute wofi menu
        "$mod, D, exec, $menu"
        # Execute hyprland window switching script
        "$mod SHIFT, P, exec, ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/nix/configs/modules/scripts/user/desktop/navigation/hyprland-window-switcher.sh"
        # Execute wofi web search script
        "$mod SHIFT, S, exec, ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/nix/configs/modules/scripts/user/desktop/search/wofi-web-search.sh"
        # Wofi-emoji
        "$mod SHIFT, E, exec, ${lib.getExe pkgs.wofi-emoji}"

        # Screenshots - piped to swappy for editing after capture
        # Take screenshot of output with printscreen key
        ", PRINT, exec, hyprshot -m output --raw | swappy -f -"
        # Take screenshot of window with mod+printscreen key
        "$mod, PRINT, exec, hyprshot -m window --raw | swappy -f -"
        # Take screenshot of region with mod+shift+printscreen key
        "$mod SHIFT, PRINT, exec, hyprshot -m region --raw | swappy -f -"

        # Toggle calculator scratchpad
        "$mod, M, exec, hyprctl clients | grep 'kitty-calculator' && hyprctl dispatch togglespecialworkspace calculator || kitty --class 'kitty-calculator' qalc &"

        # Toggle translator scratchpad
        "$mod, T, exec, hyprctl clients | grep 'kitty-translator' && hyprctl dispatch togglespecialworkspace translator || kitty --class 'kitty-translator' trans -theme random -I &"

        # Toggle AI scratchpad
        #"$mod, A, exec, hyprctl clients | grep 'kitty-ai' && hyprctl dispatch togglespecialworkspace ai || kitty --class 'kitty-ai' tenere &"
        "$mod, A, exec, hyprctl clients | grep 'kitty-ai' && hyprctl dispatch togglespecialworkspace ai || kitty --class 'kitty-ai' tgpt -m &"

        # toggle for workspace overview
        "SUPER, grave, hyprexpo:expo, toggle" # can be: toggle, off/disable or on/enable
        #"SUPER, grave, overview:toggle"
      ];

      group = {
        "col.border_active" = lib.mkForce "rgb(${base0D})";
        "col.border_inactive" = lib.mkForce "rgb(${base00})";
        groupbar = {
          font_size = config.stylix.fonts.sizes.desktop;
          text_color = "rgb(${base05})";
          gradients = true;
          #"col.active" = lib.mkForce "rgb(${base0D})";
          #"col.active" = lib.mkForce "rgb(${base0D}) rgb(${base0E}) 45deg";
          #"col.active" = lib.mkForce "rgb(${base0E}) rgb(${base0E}) 45deg";
          "col.inactive" = lib.mkForce "rgb(${base01})";
          "col.active" = lib.mkForce "rgb(${base00})";
          #col.locked_active = "rgb(${base0D})";
          #col.locked_inactive = "rgb(${base00})";
        };
      };

      misc = {
        focus_on_activate =
          true; # focus window when activated (ie by notification)
        # wake monitor if mouse/keys are touched
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        enable_swallow = true;
      };

      # This is where the actual plugin config happens
      # Plugin packages are added at the bottom 
      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(${base01})";
          workspace_method = "first 1";
          #"center current"; # [center/first] [workspace] e.g. first 1 or center m+1
          enable_gesture = true; # laptop touchpad
          gesture_fingers = 3; # 3 or 4
          gesture_distance = 150; # how far is the "max"
          gesture_positive = true; # positive = swipe down. Negative = swipe up.
        };
      };

      # Window rules for scratchpads and other programs
      windowrulev2 = [
        # Calculator Scratchpad
        "float,class:(kitty-calculator)"
        "size 500 500,class:(kitty-calculator)"
        "workspace special:calculator,class:(kitty-calculator)"

        # Translator Scratchpad
        "float,class:(kitty-translator)"
        "size 800 800,class:(kitty-translator)"
        "workspace special:translator,class:(kitty-translator)"

        # AI Scratchpad
        "float,class:(kitty-ai)"
        "size 800 800,class:(kitty-ai)"
        "workspace special:ai,class:(kitty-ai)"

        # To make KDE connect message reply window not be tiny
        "minsize 400 400, title:(Messages — KDE Connect Daemon)"
      ];

      # legacy windowrule to make Kando work
      # TODO look into updating to windowrulev2
      windowrule = [
        "noblur, kando"
        "opaque, kando"
        "size 100% 100%, kando"
        "noborder, kando"
        "noanim, kando"
        "float, kando"
        "pin, kando"
      ];

      # Needed to fix scaling bug
      xwayland = { force_zero_scaling = true; };

    };
    extraConfig = ''
      # generalized monitor rule for hotplugging displays
      # set here so per-host configs don't conflict
      monitor=,preferred,auto,1


      # Due to limitations of nix syntax, 
      # this has to be configured thru extraConfig
      # i3 like resize submap
      # uses binde to allow holding
      bind = $mod, R,submap,resize
      submap=resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , k, resizeactive, 0 -10
      binde = , j, resizeactive, 0 10
      binde = , Return,submap,reset
      submap=reset
    '';

    # This adds specific packages as plugins, not configuring them
    plugins = [
      # only one should be enabled at a time
      # they both have binds to activate with three fingers on trackpad
      # can be disabled but might as well keep only one around
      pkgs.hyprlandPlugins.hyprexpo
      #pkgs.hyprlandPlugins.hyprspace
    ];

  };
}
