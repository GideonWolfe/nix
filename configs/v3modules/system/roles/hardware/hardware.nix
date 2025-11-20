{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.custom.features.hardware;
in {
  # imports = [
  # ];

  # This option should be enabled on any machine that has physical hardware we can access
  # ie. we don't need to enable bluetooth on a VPS
  options.custom.features.hardware = {
    enable = lib.mkEnableOption "Hardware Support";
  };

  config = lib.mkIf cfg.enable {

    # Enable Bluetooth
    hardware.bluetooth.enable = true;
    # Enable GTK based manager
    services.blueman.enable = true;

    # allows to control power based on user defined profiles (required for hyprpanel battery modules )
    services.power-profiles-daemon.enable = true;
    # power control support for applications (required for hyprpanel battery modules )
    services.upower.enable = true;

    # Printing Support
    services.printing.enable = true;

    # environment.systemPackages = [
    # ];
  };
}
