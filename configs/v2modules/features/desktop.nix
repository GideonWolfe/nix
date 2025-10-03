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

    # Enable Network Manager
	  networking.networkmanager.enable = true;
    # Enable tray applet
    programs.nm-applet.enable = true;
    
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

    security.rtkit.enable = true;


    # Flatpak and appimages
    services.flatpak.enable = true;
    programs.appimage = {
         enable = true;
         binfmt = true;
    };

    # KDE Connect
    programs.kdeconnect.enable = true;
    networking.firewall = rec {
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
   

	  programs.localsend = {
        enable = true;
        openFirewall = true;
    };



  };
}
