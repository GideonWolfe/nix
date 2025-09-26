# Role-based orchestration system using NixOS module options
# This creates role options that enable package groups and features without directly configuring services
{ config, lib, pkgs, ... }:

let
  cfg = config.roles;
in
{
  # Define role options - minimal set for testing
  options.roles = {
    desktop = lib.mkEnableOption "Desktop environment role with GUI applications";
    development = lib.mkEnableOption "Development role with programming tools";
  };

  # Import role implementations when enabled
  imports = [
    (lib.mkIf cfg.desktop ../roles/desktop.nix)
    (lib.mkIf cfg.development ../roles/development.nix)
  ];
}
