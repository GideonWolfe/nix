{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let 
    cfg = config.custom.features.theming;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.custom.features.theming = {
    enable = lib.mkEnableOption "Stylix theming support";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to configure with theming packages";
    };

    image = lib.mkOption {
      type = lib.types.path;
      default = "${inputs.self}/wallpapers/topo.jpg";
      description = "Path to the wallpaper image.";
    };

    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "Theme polarity (light or dark).";
    };

    base16Scheme = lib.mkOption {
      type = lib.types.path;
      default = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      description = "Base16 color scheme file.";
    };

    opacity = lib.mkOption {
      type = lib.types.attrsOf lib.types.float;
      default = {
        applications = 1.0;
        terminal = 1.0;
        desktop = 1.0;
        popups = 1.0;
      };
      description = "Opacity settings";
    };

    cursor = lib.mkOption {
      type = lib.types.attrs;
      default = {
        package = pkgs.catppuccin-cursors.mochaDark;
        name = "catppuccin-mocha-dark-cursors";
        size = 32;
      };
      description = "Cursor theme settings.";
    };

    fontSizes = lib.mkOption {
      type = lib.types.attrsOf lib.types.int;
      default = {
        applications = 15;
        terminal = 12;
        desktop = 13;
        popups = 8;
      };
      description = "Font sizes for various UI elements.";
    };

    fonts = lib.mkOption {
      type = lib.types.attrs;
      default = {
        monospace = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font";
        };
        serif = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font";
        };
      };
      description = "Font families for monospace, sans-serif, and serif.";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix.enable = true;
    stylix.enableReleaseChecks = false;
    stylix.image = cfg.image;
    stylix.polarity = cfg.polarity;
    stylix.base16Scheme = cfg.base16Scheme;
    stylix.opacity = cfg.opacity;
    stylix.cursor = cfg.cursor;
    stylix.fonts = cfg.fonts // { sizes = cfg.fontSizes; };
    stylix.targets.plymouth.enable = false;

    # Configure specified users with theming packages
    home-manager.users = lib.genAttrs cfg.users (user: {
      home.packages = with pkgs; [
        spicetify-cli
        # QT utils
        libsForQt5.qt5ct
        qt6ct
        libsForQt5.qtcurve
        libsForQt5.qtstyleplugins

        base16-schemes

        papirus-icon-theme
        papirus-folders
        adwaita-icon-theme
        material-icons
        libsForQt5.breeze-icons # icon set for system icons

      ];
    });
  };
}
