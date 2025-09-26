{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_rpi4.override {
      argsOverride = {
        # Version for commit 99972b2fa5395542e7c24e4d894be5ede383055f
        version = "6.12.48";
        modDirVersion = "6.12.48";
        src = pkgs.fetchFromGitHub {
          owner = "raspberrypi";
          repo = "linux";
          rev = "99972b2fa5395542e7c24e4d894be5ede383055f";
          hash = "sha256-Q7PEjEpnkeBevJduxSGFvtBQpRsFUqr2crDmbW3VyEU=";
        };
      };
    });

    kernelPatches = [
      {
        name = "clockworkpi-kernel";
        patch = ./patches/clockworkpi-kernel-renamed-overlay.patch;
      }
      {
        name = "uconsole-config";
        patch = null;
        extraStructuredConfig = with lib.kernel; {
          # Enable the newly patched modules
          DRM_PANEL_CWU50 = module;
          BACKLIGHT_OCP8178 = module;

          # Power management configuration from jhewitt.net/uconsole
          REGMAP_I2C = yes;
          INPUT_AXP20X_PEK = yes;
          CHARGER_AXP20X = module;
          BATTERY_AXP20X = module;
          AXP20X_POWER = module;
          MFD_AXP20X = yes;
          MFD_AXP20X_I2C = yes;
          REGULATOR_AXP20X = yes;
          AXP20X_ADC = module;
          TI_ADC081C = module;
          CRYPTO_LIB_ARC4 = yes;
          CRC_CCITT = yes;
        };
      }
    ];

    # Kernel modules needed for uConsole hardware
    kernelModules = [
      "i2c-dev"
      "spi-bcm2835"
      "i2c-bcm2835"
      "bcm2835_dma"
      # Display and framebuffer modules
      "vc4"
      "v3d"
      "bcm2835_fb"
      "fb_sys_fops"
    ];

    # Kernel parameters optimized for uConsole
    kernelParams = [
      "console=tty1" # Use the main display console
      "console=serial0,115200" # Also enable serial for debugging
      "8250.nr_uarts=1" # UART configuration
      "cma=128M" # Contiguous Memory Allocator for GPU
      "elevator=deadline" # I/O scheduler optimized for flash storage
      "fsck.repair=yes" # Auto-repair filesystem issues
      "net.ifnames=0" # Predictable network interface names
      # Enable verbose output for debugging
      "loglevel=4" # Reduced from 7 for normal operation
    ];

    # Enable required kernel features
    kernel.sysctl = {
      "vm.swappiness" = 10; # Prefer RAM over swap
      "vm.dirty_background_ratio" = 5; # Background writeback threshold
      "vm.dirty_ratio" = 10; # Foreground writeback threshold
    };

    # Enable initrd for better hardware support
    initrd = {
      availableKernelModules =
        [ "usbhid" "usb_storage" "vc4" "pcie_brcmstb" "reset-raspberrypi" ];
      # Load uConsole-specific modules at boot
      kernelModules = [
        "ocp8178_bl" # Backlight driver
        "panel-cwu50" # Display panel driver
	      "axp20x_ac_power" # PMU driver
	      "axp20x_battery" # Battery driver
      ];
    };

    # Disable Plymouth for cleaner boot process
    plymouth.enable = false;
  };
  # Firmware is handled by nixos-hardware raspberry-pi-4 module
  # which sets hardware.enableRedistributableFirmware = true
  systemd.services."serial-getty@ttyS0".enable = false;
}