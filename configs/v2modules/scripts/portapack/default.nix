{ pkgs, lib, config, ... }:

let
  radioref = pkgs.writeShellScriptBin "radioref" ''
    exec ${pkgs.python3}/bin/python3 ${./radioref.py} "$@"
  '';
  
  portapack = pkgs.writeShellScriptBin "portapack" ''
    exec ${pkgs.python3}/bin/python3 ${./portapack.py} "$@"
  '';
in
{
  home.packages = [ radioref portapack ];
}
