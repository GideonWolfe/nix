{ pkgs, lib, config, ... }:

let
  mako-toggle-waybar = pkgs.writeShellScriptBin "mako-toggle-waybar" (builtins.readFile ./mako-toggle-waybar.sh);
in
{
  home.packages = [ mako-toggle-waybar ];
}
