{ config, lib, pkgs, inputs, ... }:

let
  hyprland-session = "${
      inputs.hyprland.packages.${pkgs.system}.hyprland
    }/share/wayland-sessions";
in {
  # Global displaymanager config
  services.xserver.displayManager = {
    session = [
      {
        manage = "window";
        name = "hyprland";
        start = "${
            inputs.hyprland.packages.${pkgs.system}.hyprland
          }/share/wayland-sessions";
      }
      {
        manage = "window";
        name = "sway";
        start = "${
            inputs.hyprland.packages.${pkgs.system}.sway
          }/share/wayland-sessions";
      }
    ];
  };

}
