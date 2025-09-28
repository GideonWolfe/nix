{ config, lib, pkgs, inputs, ... }:

let 
  cfg = config.packages;
  userPackagesDir = ../../../configs/modules/packages/user;
in {
  options.packages = {
    enable = lib.mkEnableOption "Application packages configuration";

    # Users to configure with packages
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to configure with package modules";
    };

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
    # Configure specified users with package modules
    home-manager.users = lib.genAttrs cfg.users (user: {
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
        "${userPackagesDir}/science/astronomy.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.biology) [
        "${userPackagesDir}/science/biology.nix"
        "${userPackagesDir}/science/plascad.nix"
        "${userPackagesDir}/science/ugene.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.chemistry) [
        "${userPackagesDir}/science/chemistry.nix"
        "${userPackagesDir}/science/asciiMol.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.medicine) [
        "${userPackagesDir}/science/medecine.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.engineering) [
        "${userPackagesDir}/science/engineering.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.geography) [
        "${userPackagesDir}/science/geography.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.data) [
        "${userPackagesDir}/science/data.nix"
        "${userPackagesDir}/science/euporie.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.math) [
        "${userPackagesDir}/science/math.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.education) [
        "${userPackagesDir}/science/education.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.utilities) [
        "${userPackagesDir}/science/utilities.nix"
      ];
    });
  };
}
