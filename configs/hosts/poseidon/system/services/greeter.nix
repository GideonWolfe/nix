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
        command = "${tuigreet} --time --cmd ${pkgs.hyprland}/bin/Hyprland";
        #command = "${tuigreet} --time --cmd ${pkgs.sway}/bin/sway";
        user = "greeter";

      };
    };
  };

}
