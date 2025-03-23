{ pkgs, lib, inputs, config, ... }:

{
  programs.hyprpanel.layout."bar.layouts" = lib.mkForce {
    # Right monitor
    "0" = {
      left = [ "dashboard" "workspaces" ];
      middle = [ "media" ];
      right = [
        "volume"
        "network"
        "bluetooth"
        "battery"
        "clock"
        "systray"
        "hypridle"
        "notifications"
      ];
    };
  };
}
