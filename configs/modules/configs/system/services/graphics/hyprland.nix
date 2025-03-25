{ config, lib, pkgs, inputs, ... }:

{
  programs.hyprland = {

    # Enable Hyprland
    enable = true;
    # Start using Universal Wayland Session Manager
    # Recommended on systemd systems like nix
    #withUWSM = true;
  };

}
