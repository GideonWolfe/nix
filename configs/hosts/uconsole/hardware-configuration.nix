{ config, lib, pkgs, ... }:

{
  # Device tree overlays for uConsole hardware
  hardware.deviceTree = {
    enable = true;
    filter = "bcm2711-rpi-cm4.dtb";

    overlays = [
      # Display overlay for the uConsole screen
      {
        name = "uconsole-display";
        dtsText = ''
          /dts-v1/;
          /plugin/;

          / {
            compatible = "brcm,bcm2711";
            
            fragment@0 {
              target = <&dsi1>;
              __overlay__ {
                status = "okay";
                #address-cells = <1>;
                #size-cells = <0>;
                
                port {
                  dsi_out: endpoint {
                    remote-endpoint = <&panel_in>;
                  };
                };
                
                panel: panel@0 {
                  compatible = "clockworkpi,uconsole-panel";
                  reg = <0>;
                  backlight = <&backlight>;
                  
                  port {
                    panel_in: endpoint {
                      remote-endpoint = <&dsi_out>;
                    };
                  };
                };
              };
            };
            
            fragment@1 {
              target-path = "/";
              __overlay__ {
                backlight: backlight {
                  compatible = "gpio-backlight";
                  gpios = <&gpio 12 0>;
                  default-on;
                };
              };
            };
          };
        '';
      }

      # GPIO configuration for buttons and controls
      {
        name = "uconsole-gpio";
        dtsText = ''
          /dts-v1/;
          /plugin/;

          / {
            compatible = "brcm,bcm2711";
            
            fragment@0 {
              target = <&gpio>;
              __overlay__ {
                uconsole_pins: uconsole_pins {
                  brcm,pins = <5 6 13 19 26>;
                  brcm,function = <0>; /* input */
                  brcm,pull = <2>; /* pull-up */
                };
              };
            };
          };
        '';
      }
    ];
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

  # Additional kernel modules that might be needed
  boot.extraModulePackages = with config.boot.kernelPackages;
    [
      # Add any out-of-tree modules here if needed
    ];

  # Firmware files specific to CM4
  hardware.firmware = with pkgs; [ linux-firmware raspberrypifw ];
}
