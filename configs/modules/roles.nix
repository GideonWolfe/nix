# Role-based orchestration system for NixOS configurations
# This module provides a way to define "roles" that automatically enable
# the appropriate modules and configurations for different host purposes.
{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.roles;
  
  # Define available roles and their configurations
  roleDefinitions = {
    # Server role - headless server setup
    server = {
      description = "Headless server configuration";
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

    # Development role - programming tools and environments  
    development = {
      description = "Development environment with programming tools";
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

    # Monitoring role - metrics and observability
    monitoring = {
      description = "Monitoring and observability stack";
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
  };

in {
  # Define the role options
  options.roles = mkOption {
    type = types.attrsOf types.bool;
    default = {};
    description = "Enable specific roles for this host";
  };

  # Apply configurations based on enabled roles
  config = mkMerge [
    # Server role configuration
    (mkIf cfg.server {
      environment.systemPackages = roleDefinitions.server.packages;
      services = roleDefinitions.server.services;
    })

    # Development role configuration  
    (mkIf cfg.development {
      environment.systemPackages = roleDefinitions.development.packages;
      services = roleDefinitions.development.services;
    })

    # Monitoring role configuration
    (mkIf cfg.monitoring {
      environment.systemPackages = roleDefinitions.monitoring.packages;
      services = roleDefinitions.monitoring.services;
    })
  ];
}
