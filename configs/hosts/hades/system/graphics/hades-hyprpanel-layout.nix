{ pkgs, lib, inputs, config, ... }:

{
  programs.hyprpanel.layout."bar.layouts" = lib.mkForce {
    # Right monitor
    "0" = {
      left = [ "dashboard" "workspaces" ];
      middle = [ "media" ];
      right =
        [ "volume" "network" "bluetooth" "systray" "hypridle" "notifications" ];
    };
    # Middle monitor
    "1" = {
      left = [ "dashboard" "workspaces" ];
      middle = [ "media" ];
      right = [ "volume" "clock" "notifications" ];
    };
    # Left monitor
    "2" = {
      left = [ "dashboard" "workspaces" ];
      middle = [ "media" ];
      right = [ "volume" "clock" "notifications" ];
    };
  };
}
