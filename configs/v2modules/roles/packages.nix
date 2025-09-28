{ config, lib, pkgs, inputs, pathConfig, ... }:

let 
  cfg = config.packages;
  inherit (pathConfig) userPackagesDir;
  # Get all normal users on the system
  normalUsers = lib.attrNames (lib.filterAttrs (name: user: user.isNormalUser) config.users.users);
in {
  options.packages = {
    enable = lib.mkEnableOption "Application packages configuration";

    # Science applications - hierarchical structure
    science = {
      enable = lib.mkEnableOption "Science applications";

      astronomy = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable astronomy applications";
      };

      biology = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable biology applications (includes plascad, ugene)";
      };

      chemistry = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable chemistry applications (includes asciiMol)";
      };

      medicine = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable medical applications";
      };

      engineering = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable engineering applications";
      };

      geography = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable geography applications";
      };

      data = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable data science applications (includes euporie)";
      };

      math = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable mathematics applications";
      };

      education = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable educational applications";
      };

      utilities = lib.mkOption {
        type = lib.types.bool;
        default = cfg.science.enable;
        description = "Enable scientific utilities";
      };
    };

    # Development tools (entire development directory)
    development = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable development tools and IDEs";
    };

    # Gaming applications
    gaming = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gaming applications";
    };

    # Productivity applications (entire productivity directory)
    productivity = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable productivity applications";
    };

    # Fun applications
    fun = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable fun applications";
    };
  };

  config = lib.mkIf cfg.enable {
    # Configure ALL normal users with package modules
    home-manager.users = lib.genAttrs normalUsers (user: {
      imports = [
        # Conditionally import package modules based on enabled options
      ] ++ lib.optionals cfg.development [
        "${userPackagesDir}/development"
      ] ++ lib.optionals cfg.gaming [
        "${userPackagesDir}/gaming.nix"
      ] ++ lib.optionals cfg.productivity [
        "${userPackagesDir}/productivity"
      ] ++ lib.optionals cfg.fun [
        "${userPackagesDir}/fun.nix"
      # Science packages - conditional on both science.enable and individual options
      ] ++ lib.optionals (cfg.science.enable && cfg.science.astronomy) [
        "${userPackagesDir}/science/astronomy/astronomy.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.biology) [
        "${userPackagesDir}/science/biology/biology.nix"
        "${userPackagesDir}/science/biology/plascad.nix"
        "${userPackagesDir}/science/biology/ugene.nix"
        "${userPackagesDir}/science/biology/asciiMol.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.chemistry) [
        "${userPackagesDir}/science/chemistry/chemistry.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.medicine) [
        "${userPackagesDir}/science/medecine/medecine.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.engineering) [
        "${userPackagesDir}/science/engineering/cad.nix"
        "${userPackagesDir}/science/engineering/electronics.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.geography) [
        "${userPackagesDir}/science/geography/geography.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.data) [
        "${userPackagesDir}/science/data/data.nix"
        "${userPackagesDir}/science/data/euporie.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.math) [
        "${userPackagesDir}/science/math/math.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.utilities) [
        "${userPackagesDir}/science/utilities.nix"
      ];
    });
  };
}
