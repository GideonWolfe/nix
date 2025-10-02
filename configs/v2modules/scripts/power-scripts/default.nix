{ pkgs, lib, config, ... }:

let
  lock-screen = pkgs.writeShellScriptBin "lock-screen" (builtins.readFile ./lock.sh);
  suspend-system = pkgs.writeShellScriptBin "suspend-system" (builtins.readFile ./suspend.sh);
  poweroff-system = pkgs.writeShellScriptBin "poweroff-system" (builtins.readFile ./poweroff.sh);
  reboot-system = pkgs.writeShellScriptBin "reboot-system" (builtins.readFile ./reboot.sh);
in
{
  home.packages = [ lock-screen suspend-system poweroff-system reboot-system ];
}
