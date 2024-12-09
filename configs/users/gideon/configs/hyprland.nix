{ pkgs, lib, ... }:

{

  wayland.windowManager.hyprland = {
    # allow home manager to configure hyprland	
    enable = true;

    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$menu" = "wofi --show run";

      bindm = [
        #"$mod, Return, exec, kitty"
        "$mod Shift, F, fullscreen"
        "$mod Shift, Q, killactive"
      ];

    };
    extraConfig = ''
              exec = pkill waybar & sleep 0.5 && waybar


              bind = $mod, RETURN, exec, kitty
              bind = $mod SHIFT, Q, killactive
              bind = $mod SHIFT, F, fullscreen
              bind = $mod, M, exit,
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
    '';

  };
}
