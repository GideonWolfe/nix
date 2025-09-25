{ config, lib, pkgs, ... }:

{
  # uConsole-specific kernel configuration with patches
  # Based on the 6.1-potatomania kernel from nixos-uconsole but cleaned up
  
  boot = {
    # Use a custom kernel package with uConsole-specific patches
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_rpi4.override {
      argsOverride = {
        # Version from nixos-uconsole 6.1-potatomania
        version = "6.1.63-stable_20231123";
        modDirVersion = "6.1.63";

        # Use the same Raspberry Pi kernel source as nixos-uconsole
        src = pkgs.fetchFromGitHub {
          owner = "raspberrypi";
          repo = "linux";
          rev = "stable_20231123";
          hash = "sha256-4Rc57y70LmRFwDnOD4rHoHGmfxD9zYEAwYm9Wvyb3no=";
        };
      };
    });

    # Apply uConsole-specific kernel patches
    # These patches are from: https://github.com/PotatoMania/uconsole-cm3
    kernelPatches = [
      # Hardware driver patches
      {
        name = "ocp8178-backlight-driver";
        patch = ./patches/0001-video-backlight-Add-OCP8178-backlight-driver.patch;
      }
      {
        name = "clockwork-cwu50-panel-driver";
        patch = ./patches/0002-drm-panel-add-clockwork-cwu50.patch;
      }
      {
        name = "simple-amplifier-switch";
        patch = ./patches/0003-driver-staging-add-uconsole-simple-amplifier-switch.patch;
      }
      {
        name = "axp20x-pmu-customization";
        patch = ./patches/0005-drivers-power-axp20x-customize-PMU.patch;
      }
      {
        name = "axp20x-battery-calibration";
        patch = ./patches/0006-power-axp20x_battery-implement-calibration.patch;
      }
      {
        name = "cwu50-dsi-error-status";
        patch = ./patches/0007-drm-panel-cwu50-expose-dsi-error-status-to-userspace.patch;
      }
      
      # Kernel configuration for uConsole hardware
      {
        name = "uconsole-config";
        patch = null;
        extraStructuredConfig = with lib.kernel; {
          # Enable the newly patched modules
          DRM_PANEL_CLOCKWORK_CWU50 = module;
          SIMPLE_AMPLIFIER_SWITCH = module;
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
      "i2c-dev" "spi-bcm2835" "i2c-bcm2835" "bcm2835_dma"
      # Display and framebuffer modules
      "vc4" "v3d" "bcm2835_fb" "fb_sys_fops"
    ];

    # Kernel parameters optimized for uConsole
    kernelParams = [
      "console=tty1"                  # Use the main display console
      "console=serial0,115200"        # Also enable serial for debugging
      "8250.nr_uarts=1"              # UART configuration
      "cma=128M"                     # Contiguous Memory Allocator for GPU
      "elevator=deadline"             # I/O scheduler optimized for flash storage
      "fsck.repair=yes"              # Auto-repair filesystem issues
      "net.ifnames=0"                # Predictable network interface names
      # Enable verbose output for debugging
      "loglevel=4"                   # Reduced from 7 for normal operation
    ];

    # Enable required kernel features
    kernel.sysctl = { 
      "vm.swappiness" = 10;                    # Prefer RAM over swap
      "vm.dirty_background_ratio" = 5;         # Background writeback threshold
      "vm.dirty_ratio" = 10;                   # Foreground writeback threshold
    };

    # Enable initrd for better hardware support
    initrd = {
      availableKernelModules = [ 
        "usbhid" "usb_storage" "vc4" "pcie_brcmstb" "reset-raspberrypi"
      ];
      # Load uConsole-specific modules at boot
      kernelModules = [
        "ocp8178-bl"                    # Backlight driver
        "panel-clockwork-cwu50"         # Display panel driver
        "simple-amplifier-switch"       # Audio amplifier switch
      ];
    };

    # Disable Plymouth for cleaner boot process
    plymouth.enable = false;
  };

  # Firmware files specific to CM4
  hardware.firmware = with pkgs; [ 
    linux-firmware 
  ];
}
