{ config, lib, pkgs, ... }:

{
  # Kernel configuration for uConsole (Raspberry Pi CM4)
  boot = {
    # Use the latest Raspberry Pi kernel
    kernelPackages = pkgs.linuxPackages_rpi4;

    # Kernel modules needed for uConsole hardware and display
    kernelModules = [ 
      "i2c-dev" "spi-bcm2835" "i2c-bcm2835" "bcm2835_dma"
      # Display and framebuffer modules
      "vc4" "v3d" "bcm2835_fb" "fb_sys_fops"
    ];

    # Kernel parameters for CM4 support - simplified for basic boot testing
    kernelParams = [
      "console=tty1"  # Use the main display console
      "console=serial0,115200"  # Also enable serial for debugging
      "8250.nr_uarts=1"
      "cma=128M"  # Reduced CMA for initial testing
      "elevator=deadline"
      "fsck.repair=yes"
      "net.ifnames=0"
      # Enable verbose output to see what's happening
      "loglevel=7"
      "initcall_debug"
      "debug"
    ];

    # Enable required kernel features
    kernel.sysctl = { 
      "vm.swappiness" = 10;
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
    };

    # Enable initrd for better hardware support
    initrd = {
      availableKernelModules = [ 
        "usbhid" "usb_storage" "vc4" "pcie_brcmstb" "reset-raspberrypi"
      ];
      kernelModules = [ ];
    };

    # Enable early debugging and logging
    plymouth.enable = false; # Disable splash screen for better debugging

    # Additional kernel modules that might be needed
    extraModulePackages = with config.boot.kernelPackages; [
      # Add any out-of-tree modules here if needed
    ];
  };

  # Firmware files specific to CM4
  hardware.firmware = with pkgs; [ 
    linux-firmware 
    # raspberrypifw - removed due to build issues, nixos-hardware should provide this
  ];
}
