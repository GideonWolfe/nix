{ pkgs, lib, inputs, config, ... }:

{

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DSI-1, preferred, auto, 1, transform, 3" # 1x scale, rotate 270 degrees
    ];
  };
}
