{ pkgs, lib, config, ... }:

let
  post-commit-hook = pkgs.writeShellScriptBin "post-commit-hook" (builtins.readFile ./post-commit-hook.sh);
in
{
  home.packages = [ post-commit-hook ];
}
