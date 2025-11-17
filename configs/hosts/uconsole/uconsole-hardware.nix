{ config, lib, pkgs, ... }:

{
  # Hardware-specific configuration for uConsole
  hardware = {

    # Enable I2C for various uConsole components
    i2c.enable = true;

  };

  # Battery monitoring service
  services.upower = {
    enable = true;
    percentageLow = 10;
    percentageCritical = 5;
    percentageAction = 3;
  };

  # Custom udev rules for uConsole hardware
  services.udev.extraRules = ''
    # GPIO access for regular users
    SUBSYSTEM=="gpio", GROUP="gpio", MODE="0660"

    # I2C access
    SUBSYSTEM=="i2c-dev", GROUP="i2c", MODE="0660"

    # SPI access
    SUBSYSTEM=="spidev", GROUP="spi", MODE="0660"

    # Trackball/keyboard custom rules can be added here
  '';

  # ERROR interfering with services.power-profiles
  # Power management for battery operation
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #     START_CHARGE_THRESH_BAT0 = 20;
  #     STOP_CHARGE_THRESH_BAT0 = 80;
  #   };
  # };
}
