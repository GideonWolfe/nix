# Role-based orchestration system for NixOS configurations
# This module provides a way to define "roles" that automatically enable
# the appropriate modules and configurations for different host purposes.
{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.roles;
  
  # Define available roles and their required modules
  roleDefinitions = {
    # Desktop role - full GUI workstation setup
    desktop = {
      description = "Full desktop environment with GUI applications";
      modules = [
        ./configs/system/services/graphics/hyprland.nix
        ./configs/system/services/graphics/wayland.nix
        ./configs/system/services/login/displayManager.nix
        ./configs/system/services/login/greeter.nix
        ./configs/system/services/audio/pipewire.nix
        ./configs/system/services/security/gnome-keyring.nix
        ./configs/system/services/gvfs.nix
        ./configs/system/services/nautilus.nix
        ./configs/system/services/appimage.nix
      ];
      packages = with pkgs; [
        firefox
        chromium
        thunderbird
        libreoffice
        gimp
        vlc
        discord
        slack
      ];
      services = {
        # Enable common desktop services
        xserver.enable = true;
        printing.enable = true;
        blueman.enable = true;
      };
    };

    # Server role - headless server setup
    server = {
      description = "Headless server configuration";
      modules = [
        # Only include existing modules for now
      ];
      packages = with pkgs; [
        htop
        tmux
        vim
        curl
        wget
        git
        tree
        neofetch
      ];
      services = {
        openssh.enable = true;
      };
    };

    # Monitoring role - metrics and observability
    monitoring = {
      description = "Monitoring and observability stack";
      modules = [
        # Will add monitoring-specific modules later
      ];
      packages = with pkgs; [
        # Basic monitoring tools
        htop
        iotop
        nethogs
        lsof
      ];
      services = {
        prometheus = {
          enable = true;
          port = 9090;
          listenAddress = "0.0.0.0:9090";
        };
        grafana = {
          enable = true;
          settings.server = {
            http_port = 3000;
            http_addr = "0.0.0.0";
          };
        };
        loki = {
          enable = true;
          configuration = {
            server.http_listen_port = 3100;
            auth_enabled = false;
            
            ingester = {
              lifecycler = {
                address = "127.0.0.1";
                ring = {
                  kvstore = {
                    store = "inmemory";
                  };
                  replication_factor = 1;
                };
                final_sleep = "0s";
              };
              chunk_idle_period = "5m";
              chunk_retain_period = "30s";
            };
            
            schema_config = {
              configs = [{
                from = "2020-10-24";
                store = "boltdb";
                object_store = "filesystem";
                schema = "v11";
                index = {
                  prefix = "index_";
                  period = "168h";
                };
              }];
            };
            
            storage_config = {
              boltdb = {
                directory = "/tmp/loki/index";
              };
              filesystem = {
                directory = "/tmp/loki/chunks";
              };
            };
          };
        };
      };
    };

    # Development role - programming tools and environments
    development = {
      description = "Development environment with programming tools";
      modules = [
        ./configs/system/services/virtualization/docker.nix
      ];
      packages = with pkgs; [
        neovim
        git
        gh
        docker
        docker-compose
        nodejs
        python3
        rustc
        cargo
        gcc
        gnumake
        cmake
        pkg-config
      ];
      services = {
        docker.enable = true;
      };
    };

    # Gaming role - gaming setup
    gaming = {
      description = "Gaming setup with Steam and related tools";
      modules = [
        ./configs/system/services/gaming/steam.nix
        ./configs/system/services/graphics/hyprland.nix
        ./configs/system/services/graphics/wayland.nix
      ];
      packages = with pkgs; [
        steam
        discord
        obs-studio
        lutris
      ];
      services = {
        # Gaming-specific services would go here
      };
    };
  };

  # Helper function to merge role configurations
  mergeRoleConfigs = roles: let
    enabledRoles = lib.filterAttrs (name: enabled: enabled) roles;
    enabledRoleConfigs = lib.mapAttrsToList (name: _: roleDefinitions.${name}) enabledRoles;
  in {
    modules = lib.unique (lib.flatten (map (role: role.modules or []) enabledRoleConfigs));
    packages = lib.unique (lib.flatten (map (role: role.packages or []) enabledRoleConfigs));
    services = lib.foldl lib.recursiveUpdate {} (map (role: role.services or {}) enabledRoleConfigs);
  };

  # Get the merged configuration for all enabled roles
  mergedConfig = mergeRoleConfigs cfg;

in {
  # Define the role options
  options.roles = lib.mkOption {
    type = lib.types.submodule {
      options = lib.mapAttrs (roleName: roleConfig: 
        lib.mkEnableOption roleConfig.description
      ) roleDefinitions;
    };
    default = {};
    description = "Enable specific roles for this host";
  };

  # Apply the merged configuration
  config = lib.mkMerge [
    # Import modules for enabled roles
    {
      imports = mergedConfig.modules;
    }
    
    # Add packages for enabled roles
    {
      environment.systemPackages = mergedConfig.packages;
    }
    
    # Apply service configurations for enabled roles
    mergedConfig.services
  ];
}
