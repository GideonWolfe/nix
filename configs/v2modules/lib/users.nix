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

    initialHashedPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Initial hashed password for the user";
    };

    profilePicture = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to the user's profile picture";
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
    } // lib.optionalAttrs (config.custom.user.initialHashedPassword != null) {
      initialHashedPassword = config.custom.user.initialHashedPassword;
    };

    # Create home-manager configuration for the user
    home-manager.users.${config.custom.user.name} = lib.mkMerge [
      {
        # Enable unfree packages for homemanager
        nixpkgs.config.allowUnfree = true;
      }
      
      # Add profile picture if specified
      (lib.mkIf (config.custom.user.profilePicture != null) {
        home.file."profile.png".source = config.custom.user.profilePicture;
      })
    ];
  };
}
