{ config, lib, pkgs, inputs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${
      inputs.hyprland.packages.${pkgs.system}.hyprland
    }/share/wayland-sessions";
in {
  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Command to launch tuigreet, a TUI based greeter
        command =
          "${tuigreet} --time  --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions:${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session";
        user = "greeter";
      };
    };
  };

}
