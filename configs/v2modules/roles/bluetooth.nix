{ config, lib, pkgs, pathConfig ? {}, ... }:

{
  options.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth support and services";
  };

  config = lib.mkIf config.bluetooth.enable {
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
