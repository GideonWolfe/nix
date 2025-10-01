{ config, lib, pkgs, inputs, pathConfig, ... }:

let 
  cfg = config.custom.features.packages;
  inherit (pathConfig) packagesDir;
in {
  options.custom.features.packages = {
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
    # Configure the system user with package modules
    home-manager.users.${config.custom.user.name} = {
      imports = [
        # Conditionally import package modules based on enabled options
      ] ++ lib.optionals cfg.development [
        "${packagesDir}/development/dedoc.nix"
        "${packagesDir}/development/js.nix"
        "${packagesDir}/development/python.nix"
        "${packagesDir}/development/rust.nix"
        "${packagesDir}/development/security.nix"
        "${packagesDir}/development/utils.nix"
      ] ++ lib.optionals cfg.gaming [
        "${packagesDir}/gaming/gaming.nix"
      ] ++ lib.optionals cfg.productivity [
        "${packagesDir}/productivity/productivity.nix"
        "${packagesDir}/productivity/audio.nix"
        "${packagesDir}/productivity/basalt-tui.nix"
        "${packagesDir}/productivity/video.nix"
        "${packagesDir}/productivity/web.nix"
        "${packagesDir}/productivity/comms/comms.nix"
        "${packagesDir}/productivity/comms/signal.nix"
        "${packagesDir}/productivity/comms/matrix.nix"
        "${packagesDir}/productivity/comms/irc.nix"
        "${packagesDir}/productivity/news/news.nix"
        "${packagesDir}/productivity/news/hackernews-tui.nix"
      ] ++ lib.optionals cfg.fun [
        "${packagesDir}/utilities/fun.nix"
      # Science packages - conditional on both science.enable and individual options
      ] ++ lib.optionals (cfg.science.enable && cfg.science.astronomy) [
        "${packagesDir}/science/astronomy/astronomy.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.biology) [
        "${packagesDir}/science/biology/biology.nix"
        "${packagesDir}/science/biology/plascad.nix"
        "${packagesDir}/science/biology/ugene.nix"
        "${packagesDir}/science/biology/asciiMol.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.chemistry) [
        "${packagesDir}/science/chemistry/chemistry.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.medicine) [
        "${packagesDir}/science/medecine/medecine.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.engineering) [
        "${packagesDir}/science/engineering/cad.nix"
        "${packagesDir}/science/engineering/electronics.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.geography) [
        "${packagesDir}/science/geography/geography.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.data) [
        "${packagesDir}/science/data/data.nix"
        "${packagesDir}/science/data/euporie.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.math) [
        "${packagesDir}/science/math/math.nix"
      ] ++ lib.optionals (cfg.science.enable && cfg.science.utilities) [
        "${packagesDir}/science/utilities.nix"
      ];
    };
  };
}
