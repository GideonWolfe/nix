{
  config,
  lib,
  pkgs,
  inputs,
  pathConfig ? { },
  ...
}:

let
  cfg = config.custom.features.desktop;
in
{
  # imports = [
  # ];

  # This option should be enabled on any machine that has physical hardware we can access
  # ie. we don't need to enable bluetooth on a VPS
  options.custom.features.desktop = {
    enable = lib.mkEnableOption "Hardware Support";
  };

  config = lib.mkIf cfg.enable {

    # Boot splash
    boot.plymouth = {
      enable = true;
      # Pass in the package of themes we also downloaded
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      # Choose the theme
      # default is "stylix" but idk how to change it from stylix config
      # https://github.com/adi1090x/plymouth-themes
      theme = "motion";
    };

    # Greeter
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time  --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session";
          user = "greeter";
        };
      };
    };

    # Enable Sound
    services.pipewire = {
      # Enable Pipewire
      enable = true;
      # Use Pipewire as primary server
      audio.enable = true;
      # Enable wireplummber session manager
      wireplumber.enable = true;
      # Handle other audio servers too
      jack.enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # Enable Bluetooth
    hardware.bluetooth.enable = true;
    # Enable GTK based manager
    services.blueman.enable = true;

    # Enable network managertray applet
    programs.nm-applet.enable = true;

    # Enable gnome-keyring
    services.gnome.gnome-keyring.enable = true;
    # Give seahorse access to GNOME Keyring
    programs.seahorse.enable = true;

    # Make XDG Portals available
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.lxqt.xdg-desktop-portal-lxqt
      ];
    };
    xdg.portal.wlr.enable = true;
    xdg.portal.lxqt.enable = true;

    # FlatPak Support
    services.flatpak.enable = true;
    # Enable AppImage Support
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # Hyprland
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    # required for sway according to docs
    security.polkit.enable = true;
    # Required for swaylock to work
    security.pam.services.swaylock = {
      text = "	auth include login\n";
    };

    # allows to control power based on user defined profiles (required for hyprpanel battery modules )
    services.power-profiles-daemon.enable = true;
    # power control support for applications (required for hyprpanel battery modules )
    services.upower.enable = true;

    # Printing Support
    services.printing.enable = true;

    # RTL-SDR Support
    hardware.rtl-sdr = {
      enable = true;
    };

    # environment.systemPackages = [
    # ];
  };
}
