# Simple role-based orchestration system for NixOS configurations
{ config, lib, pkgs, ... }:

let
  cfg = config.roles;
  
  roleDefinitions = {
    server = {
      description = "Headless server configuration";
      packages = with pkgs; [ htop tmux vim curl wget git tree neofetch ];
    };
    
    development = {
      description = "Development environment";
      packages = with pkgs; [ neovim git gh nodejs python3 rustc cargo gcc ];
    };
    
    monitoring = {
      description = "Monitoring tools";
      packages = with pkgs; [ htop iotop nethogs prometheus grafana ];
    };
    
    desktop = {
      description = "Desktop environment";
      packages = with pkgs; [ firefox chromium thunderbird libreoffice gimp ];
    };
    
    gaming = {
      description = "Gaming applications";
      packages = with pkgs; [ steam discord obs-studio ];
    };
  };

  getRolePackages = roles: let
    enabledRoles = lib.filterAttrs (name: enabled: enabled) roles;
    enabledRoleConfigs = lib.mapAttrsToList (name: _: roleDefinitions.${name}) enabledRoles;
  in
    lib.unique (lib.flatten (map (role: role.packages or []) enabledRoleConfigs));

in {
  options.roles = lib.mkOption {
    type = lib.types.submodule {
      options = lib.mapAttrs (roleName: roleConfig: 
        lib.mkEnableOption roleConfig.description
      ) roleDefinitions;
    };
    default = {};
    description = "Enable specific roles for this host";
  };

  config = {
    environment.systemPackages = getRolePackages cfg;
  };
}
