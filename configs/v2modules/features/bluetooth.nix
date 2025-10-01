{ config, lib, pkgs, pathConfig ? {}, ... }:

{
  options.custom.features.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth support and services";
  };

  config = lib.mkIf config.custom.features.bluetooth.enable {
    # Enable Bluetooth hardware support
    hardware.bluetooth.enable = true;
    
    # Enable GTK based manager
    services.blueman.enable = true;

    # Install bluetooth-related system packages
    environment.systemPackages = with pkgs; [
      bluez        # Bluetooth protocol stack
      blueman      # Bluetooth manager GUI
    ];
  };
}
