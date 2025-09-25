{ config, lib, pkgs, ... }:

{
  # Hardware-specific configuration for uConsole
  hardware = {
    enableRedistributableFirmware = true;

    # Enable device tree support
    deviceTree.enable = true;

    # Enable Raspberry Pi specific hardware with uConsole optimizations
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      fkms-3d.enable = true;
      dwc2.enable = true;
      dwc2.dr_mode = "host";
      #audio.enable = true;  # Enable later when working
    };

    # Enable I2C for various uConsole components
    i2c.enable = true;

    # Bluetooth support
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
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

  # Power management for battery operation
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Display configuration for uConsole screen (disabled for initial boot testing)
  # services.xserver = {
  #   enable = true;

  #   # Configure for the uConsole's display
  #   videoDrivers = [ "fbdev" "modesetting" ];

  #   # Display manager (you can change this to your preference)
  #   displayManager.lightdm.enable = true;
  #   displayManager.lightdm.greeters.gtk.enable = true;

  #   # Window manager (adjust to your preference)
  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [ dmenu i3status i3lock ];
  #   };

  #   # Input configuration for uConsole keyboard/trackball
  #   libinput = {
  #     enable = true;
  #     touchpad = {
  #       tapping = true;
  #       scrollMethod = "twofinger";
  #     };
  #   };

  #   # Screen configuration for 5" 1280x720 display
  #   xrandrHeads = [{
  #     output = "DSI-1";
  #     primary = true;
  #     monitorConfig = ''
  #       Option "PreferredMode" "1280x720"
  #     '';
  #   }];
  # };

  # Audio configuration (disabled for initial testing)
  # sound.enable = true;
  # hardware.pipewire.enable = true;
}
