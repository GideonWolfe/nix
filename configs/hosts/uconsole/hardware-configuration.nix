{ config, lib, pkgs, ... }:

{
  # Device tree overlays for uConsole hardware
  hardware.deviceTree = {
    enable = true;
    # Let nixos-hardware handle the filter (bcm2711-rpi-4*.dtb)
    # Add uConsole-specific overlays
    overlays = [
      # uConsole display panel overlay
      {
        name = "devterm-panel-uc";
        filter = "bcm2711-rpi-cm4.dtb";
        dtsText = ''
          /dts-v1/;
          /plugin/;

          / {
            compatible = "brcm,bcm2711";

            fragment@0 {
              target=<&dsi1>;
              __overlay__ {
                #address-cells = <1>;
                #size-cells = <0>;
                status = "okay";

                port {
                  dsi_out_port: endpoint {
                    remote-endpoint = <&panel_dsi_port>;
                  };
                };

                panel_cwu50: panel@0 {
                  compatible = "clockwork,cwu50";
                  reg = <0>;
                  reset-gpio = <&gpio 8 1>;
                  backlight = <&ocp8178_backlight>;
                  rotation = <90>;

                  port {
                    panel_dsi_port: endpoint {
                      remote-endpoint = <&dsi_out_port>;
                    };
                  };
                };
              };
            };

            fragment@1 {
              target-path = "/";
              __overlay__  {
                ocp8178_backlight: backlight@0 {
                  compatible = "ocp8178-backlight";
                  backlight-control-gpios = <&gpio 9 0>;
                  default-brightness = <5>;
                };
              };
            };
          };
        '';
      }

      # uConsole misc hardware (I2C, SPI, UART)
      {
        name = "devterm-misc";
        filter = "bcm2711-rpi-cm4.dtb";
        dtsText = ''
          /dts-v1/;
          /plugin/;

          /{
            compatible = "brcm,bcm2711";

            fragment@0 {
              target = <&i2c1>;
              __overlay__ {
                #address-cells = <1>;
                #size-cells = <0>;
                pinctrl-names = "default";
                pinctrl-0 = <&i2c1_pins>;
                status = "okay";

                adc101c: adc@54 {
                  reg = <0x54>;
                  compatible = "ti,adc101c";
                  status = "okay";
                };
              };
            };

            fragment@1 {
              target = <&uart1>;
              __overlay__ {
                pinctrl-names = "default";
                pinctrl-0 = <&uart1_pins>;
                status = "okay";
              };
            };

            fragment@2 {
              target = <&gpio>;
              __overlay__ {
                i2c1_pins: i2c1 {
                  brcm,pins = <44 45>;
                  brcm,function = <6>;
                };

                uart1_pins: uart1_pins {
                  brcm,pins = <14 15>;
                  brcm,function = <2>;
                  brcm,pull = <0 2>;
                };
              };
            };

            fragment@3 {
              target-path = "/chosen";
              __overlay__ {
                bootargs = "8250.nr_uarts=1";
              };
            };
          };
        '';
      }

      # Graphics overlay for proper display support
      {
        name = "vc4-kms-v3d-pi4,cma-384";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/vc4-kms-v3d-pi4.dtbo";
        filter = "bcm2711-rpi-cm4.dtb";
      }
    ];
  };

    # filter = lib.mkForce "bcm2711-rpi-cm4.dtb";
    # overlays = [
    #   # Display overlay for the uConsole screen
    #   {
    #     name = "uconsole-display";
    #     dtsText = ''
    #       /dts-v1/;
    #       /plugin/;
    #
    #       / {
    #         compatible = "brcm,bcm2711";
    #         
    #         fragment@0 {
    #           target = <&dsi1>;
    #           __overlay__ {
    #             status = "okay";
    #             #address-cells = <1>;
    #             #size-cells = <0>;
    #             
    #             port {
    #               dsi_out: endpoint {
    #                 remote-endpoint = <&panel_in>;
    #               };
    #             };
    #             
    #             panel: panel@0 {
    #               compatible = "clockworkpi,uconsole-panel";
    #               reg = <0>;
    #               backlight = <&backlight>;
    #               
    #               port {
    #                 panel_in: endpoint {
    #                   remote-endpoint = <&dsi_out>;
    #                 };
    #               };
    #             };
    #           };
    #         };
    #         
    #         fragment@1 {
    #           target-path = "/";
    #           __overlay__ {
    #             backlight: backlight {
    #               compatible = "gpio-backlight";
    #               gpios = <&gpio 12 0>;
    #               default-on;
    #             };
    #           };
    #         };
    #       };
    #     '';
    #   }
    #
    #   # GPIO configuration for buttons and controls
    #   {
    #     name = "uconsole-gpio";
    #     dtsText = ''
    #       /dts-v1/;
    #       /plugin/;
    #
    #       / {
    #         compatible = "brcm,bcm2711";
    #         
    #         fragment@0 {
    #           target = <&gpio>;
    #           __overlay__ {
    #             uconsole_pins: uconsole_pins {
    #               brcm,pins = <5 6 13 19 26>;
    #               brcm,function = <0>; /* input */
    #               brcm,pull = <2>; /* pull-up */
    #             };
    #           };
    #         };
    #       };
    #     '';
    #   }
    #];
  #};

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
  hardware.firmware = with pkgs; [ 
    linux-firmware 
    # raspberrypifw - removed due to build issues, nixos-hardware should provide this
  ];

  # File systems configuration for SD card
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = [ "nofail" "noauto" ];
    };
  };

  # Swap configuration (optional, but helpful for limited RAM)
  swapDevices = [
    {
      device = "/swapfile";
      size = 1024; # 1GB swap
    }
  ];
}
