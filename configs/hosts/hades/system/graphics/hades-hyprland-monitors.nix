{ pkgs, lib, inputs, config, ... }:

{

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-3, preferred, 0x0, 1"
      "DP-2, preferred, 2560x-25, 1"
      "DP-1, preferred, 5120x-335, 1, transform, 3"
    ];
    workspace = [
      "1, monitor:DP-3, default:true"
      "2, monitor:DP-3, default:true"
      "3, monitor:DP-3, default:true"
      "4, monitor:DP-2, default:true"
      "5, monitor:DP-2, default:true"
      "6, monitor:DP-2, default:true"
      "7, monitor:DP-2, default:true"
      "8, monitor:DP-1, default:true"
      "9, monitor:DP-1, default:true"
      "10, monitor:DP-1, default:true"
    ];
  };
}
