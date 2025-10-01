{ config, lib, pkgs, inputs, pathConfig, ... }:

let 
  cfg = config.custom.features.desktop;
  inherit (pathConfig) userModulesDir systemModulesDir;
in {
  options.custom.features.desktop = {
    enable = lib.mkEnableOption "Essential desktop configuration with UI components";

    # Desktop Environment Selection
    desktopEnvironment = lib.mkOption {
      type = lib.types.enum [ "hyprland" "sway" "none" ];
      default = "none";
      description = "Which desktop environment to enable";
    };

    # Optional UI Components
    gestures = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable touchpad gestures (fusuma)";
    };

  };

  config = lib.mkIf cfg.enable {
    # Display manager/greeter configuration
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time  --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session";
          user = "greeter";
        };
      };
    };

    # NixOS system-level configuration
    # Enable fish shell at system level (needed for user shells)
    programs.fish.enable = true;
    
    # Enable desktop environment programs at system level
    programs.hyprland = lib.mkIf (cfg.desktopEnvironment == "hyprland") {
      enable = true;
      withUWSM = true;
    };
    programs.sway = lib.mkIf (cfg.desktopEnvironment == "sway") {
      enable = true;
    };

    services.dbus.enable = true;
    xdg.portal = lib.mkIf (cfg.desktopEnvironment != "none") {
      enable = true;
      wlr.enable = lib.mkIf (cfg.desktopEnvironment == "sway") true;
      extraPortals = lib.optionals (cfg.desktopEnvironment == "hyprland") [
        pkgs.xdg-desktop-portal-hyprland
      ] ++ lib.optionals (cfg.desktopEnvironment == "sway") [
        pkgs.xdg-desktop-portal-wlr
      ];
    };

    # Audio support for desktop
    security.rtkit.enable = true;


    services.flatpak.enable = true;

    # # Configure specified users with desktop Home Manager modules
    # home-manager.users = lib.genAttrs cfg.users (user: {
    #   # Set required Home Manager state version
    #   home.stateVersion = "25.05";
      
    #   imports = [
    #     # Essential desktop modules only - no common.nix
    #     "${userModulesDir}/cursor/cursor.nix"
    #     "${userModulesDir}/gtk/gtk.nix"
    #     "${userModulesDir}/qt/qt.nix"
    #     "${userModulesDir}/wofi/wofi.nix"
    #     "${userModulesDir}/swappy/swappy.nix"
    #     "${userModulesDir}/kando/kando.nix"
    #     "${userModulesDir}/clipse/clipse.nix"
    #     "${userModulesDir}/shell/fish.nix"
    #   ] ++ lib.optionals cfg.gestures [
    #     "${userModulesDir}/fusuma/fusuma.nix"
    #   # Desktop Environment specific modules
    #   ] ++ lib.optionals (cfg.desktopEnvironment == "hyprland") [
    #     "${userModulesDir}/hypr/hyprland.nix"
    #     "${userModulesDir}/hypr/hyprpaper.nix"
    #     "${userModulesDir}/hypr/hypridle.nix"
    #     "${userModulesDir}/hypr/hyprlock.nix"
    #     #"${userModulesDir}/hypr/hyprpanel.nix"
    #   ] ++ lib.optionals (cfg.desktopEnvironment == "sway") [
    #     "${userModulesDir}/sway/sway.nix"
    #     "${userModulesDir}/sway/swaylock.nix"
    #     "${userModulesDir}/sway/swayidle.nix"
    #     "${userModulesDir}/waybar/waybar.nix"
    #   ];
    # });
  };
}
