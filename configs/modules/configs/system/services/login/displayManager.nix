{ config, lib, pkgs, inputs, ... }:

{
  # Global displaymanager config
  # Hyprland creates its own entries
  services.xserver.displayManager = {
    session = [
      # Adding entry for sway since it doesn't add one automatically
      {
        manage = "window";
        name = "sway";
        start = "${pkgs.sway}/bin/sway";
      }
    ];
  };
}
