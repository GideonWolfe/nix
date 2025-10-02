{ pkgs, lib, config, ... }:

let
  hyprland-window-switcher = pkgs.writeShellScriptBin "hyprland-window-switcher" (builtins.readFile ./hyprland-window-switcher.sh);
in
{
  home.packages = [ hyprland-window-switcher ];
}
