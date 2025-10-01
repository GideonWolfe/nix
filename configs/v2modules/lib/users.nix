{ config, lib, pkgs, ... }:

{
  options.custom.user = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "The primary user for this system";
    };

    home = lib.mkOption {
      type = lib.types.str;
      description = "Home directory path for the user";
    };

    shell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.fish;
      description = "Default shell for the user";
    };

    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional groups for the user";
    };

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Packages to install for this user";
    };

    openssh = {
      authorizedKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "SSH public keys for this user";
      };
    };

    secretsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to the user's SOPS secrets file";
      example = "../../../../secrets/gideon_secrets.yaml";
    };

    initialPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Initial password for the user (for testing only)";
    };

    homeManagerConfig = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Home Manager configuration for this user";
    };
  };

  config = {
    # Create the system user
    users.users.${config.custom.user.name} = {
      isNormalUser = true;
      home = config.custom.user.home;
      shell = config.custom.user.shell;
      extraGroups = config.custom.user.extraGroups;
      packages = config.custom.user.packages;
      openssh.authorizedKeys.keys = config.custom.user.openssh.authorizedKeys;
    } // lib.optionalAttrs (config.custom.user.initialPassword != null) {
      initialPassword = config.custom.user.initialPassword;
    };

    # Create home-manager configuration for the user
    home-manager.users.${config.custom.user.name} = {
      home.stateVersion = "25.05";
      # fix conflict with stylix default
      stylix.targets.spicetify.enable = false;
      # Enable unfree packages for homemanager
      nixpkgs.config.allowUnfree = true;
    } // config.custom.user.homeManagerConfig;
  };
}
