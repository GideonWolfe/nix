{ pkgs, lib, config, ... }:

let
  # Create the script package
  wofi-web-search = pkgs.writeShellScriptBin "wofi-web-search" (builtins.readFile ./wofi-web-search.sh);
in
{
  # Add the script to the user's PATH
  home.packages = [ wofi-web-search ];
}
