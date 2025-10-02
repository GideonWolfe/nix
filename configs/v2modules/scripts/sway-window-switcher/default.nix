{ pkgs, lib, config, ... }:

let
  sway-window-switcher = pkgs.writeShellScriptBin "sway-window-switcher" (builtins.readFile ./sway-window-switcher.sh);
in
{
  home.packages = [ sway-window-switcher ];
}
