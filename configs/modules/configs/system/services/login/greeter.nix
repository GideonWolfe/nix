{ config, lib, pkgs, inputs, ... }:

let tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  # Enable greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Command to launch tuigreet, a TUI based greeter
        command =
          #INFO: This is how to manually bind sessions, but they seem to automatically populate fine
          #"${tuigreet} --time  --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session";
          "${tuigreet} --time --remember --remember-user-session";
        user = "greeter";
      };
    };
  };

}
