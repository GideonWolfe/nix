{ config, lib, pkgs, ... }:

{
  # Device tree overlays for uConsole hardware
  hardware.deviceTree = {
    enable = true;
    # Let nixos-hardware handle the filter (bcm2711-rpi-4*.dtb)
    # Using the exact active overlays from clockworkpi-uconsole-overlays.nix
    overlays = [
      # devterm-misc: I2C, SPI, UART, and GPIO configuration
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
              target = <&spi4>;
              __overlay__ {
                pinctrl-names = "default";
                pinctrl-0 = <&spi4_pins &spi4_cs_pins>;
                cs-gpios = <&gpio 4 1>;
                status = "okay";

                spidev4_0: spidev@0 {
                  compatible = "spidev";
                  reg = <0>;      /* CE0 */
                  #address-cells = <1>;
                  #size-cells = <0>;
                  spi-max-frequency = <125000000>;
                  status = "okay";
                };
              };
            };

            fragment@2 {
              target = <&uart1>;
              __overlay__ {
                pinctrl-names = "default";
                pinctrl-0 = <&uart1_pins>;
                status = "okay";
              };
            };

            fragment@3 {
              target = <&gpio>;
              __overlay__ {
                i2c1_pins: i2c1 {
                  brcm,pins = <44 45>;
                  brcm,function = <6>;
                };

                spi4_pins: spi4_pins {
                  brcm,pins = <6 7>;
                  brcm,function = <7>;
                };

                spi4_cs_pins: spi0_cs_pins {
                  brcm,pins = <4>;
                  brcm,function = <1>;
                };

                uart1_pins: uart1_pins {
                  brcm,pins = <14 15>;
                  brcm,function = <2>;
                  brcm,pull = <0 2>;
                };
              };
            };

            fragment@4 {
              target-path = "/chosen";
              __overlay__ {
                bootargs = "8250.nr_uarts=1";
              };
            };
          };
        '';
      }

      # devterm-panel-uc: uConsole display panel configuration
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

      # devterm-pmu: Power Management Unit configuration
      {
        name = "devterm-pmu";
        filter = "bcm2711-rpi-cm4.dtb";
        dtsText = ''
          /dts-v1/;
          /plugin/;

          / {
            compatible = "brcm,bcm2711";

            fragment@0 {
              target = <&i2c0if>;
              __overlay__ {
                #address-cells = <1>;
                #size-cells = <0>;
                pinctrl-0 = <&i2c0_pins>;
                pinctrl-names = "default";
                status = "okay";

                axp22x: pmic@34 {
                  interrupt-controller;
                  #interrupt-cells = <1>;
                  compatible = "x-powers,axp223";
                  reg = <0x34>; /* i2c address */
                  interrupt-parent = <&gpio>;
                  interrupts = <2 8>;  /* IRQ_TYPE_EDGE_FALLING */
                  irq-gpios = <&gpio 2 0>;

                  regulators {
                    x-powers,dcdc-freq = <3000>;

                    reg_aldo1: aldo1 {
                      regulator-always-on;
                      regulator-min-microvolt = <3300000>;
                      regulator-max-microvolt = <3300000>;
                      regulator-name = "audio-vdd";
                    };

                    reg_aldo2: aldo2 {
                      regulator-always-on;
                      regulator-min-microvolt = <3300000>;
                      regulator-max-microvolt = <3300000>;
                      regulator-name = "display-vcc";
                    };

                    reg_dldo2: dldo2 {
                      regulator-always-on;
                      regulator-min-microvolt = <3300000>;
                      regulator-max-microvolt = <3300000>;
                      regulator-name = "dldo2";
                    };

                    reg_dldo3: dldo3 {
                      regulator-always-on;
                      regulator-min-microvolt = <3300000>;
                      regulator-max-microvolt = <3300000>;
                      regulator-name = "dldo3";
                    };

                    reg_dldo4: dldo4 {
                      regulator-always-on;
                      regulator-min-microvolt = <3300000>;
                      regulator-max-microvolt = <3300000>;
                      regulator-name = "dldo4";
                    };
                  };

                  battery_power_supply: battery-power-supply {
                    compatible = "x-powers,axp221-battery-power-supply";
                    monitored-battery = <&battery>;
                  };

                  ac_power_supply: ac_power_supply {
                    compatible = "x-powers,axp221-ac-power-supply";
                  };
                };
              };
            };

            fragment@1 {
              target = <&i2c0if>;
              __overlay__ {
                compatible = "brcm,bcm2708-i2c";
              };
            };

            fragment@2 {
              target-path = "/aliases";
              __overlay__ {
                i2c0 = "/soc/i2c@7e205000";
              };
            };

            fragment@3 {
              target-path = "/";
              __overlay__  {
                battery: battery@0 {
                  compatible = "simple-battery";
                  constant-charge-current-max-microamp = <2100000>;
                  voltage-min-design-microvolt = <3300000>;
                };
              };
            };
          };
        '';
      }
      {
        name = "vc4-kms-v3d-pi4,cma-384";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/vc4-kms-v3d-pi4.dtbo";
        filter = "bcm2711-rpi-cm4.dtb";
      }
      {
        name = "audremap,pins_12_13";
        dtboFile = "${config.boot.kernelPackages.kernel}/dtbs/overlays/audremap.dtbo";
        filter = "bcm2711-rpi-cm4.dtb";
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
