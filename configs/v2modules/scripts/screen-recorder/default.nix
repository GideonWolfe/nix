{ pkgs, lib, config, ... }:

let
  screen-recorder = pkgs.writeShellScriptBin "screen-recorder" (builtins.readFile ./screen-recorder.sh);
in
{
  home.packages = [ screen-recorder ];
}
