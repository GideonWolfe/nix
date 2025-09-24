{ config, lib, pkgs, ... }:

{
  # uConsole-specific kernel configuration with patches
  # Based on the 6.1-potatomania kernel from nixos-uconsole but cleaned up

  boot = {
    # Use a custom kernel package with uConsole-specific patches
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_rpi4.override {
      argsOverride = {
        # Version for commit 99972b2fa5395542e7c24e4d894be5ede383055f
        version = "6.12.48";
        modDirVersion = "6.12.48";

        # Use the same Raspberry Pi kernel source as nixos-uconsole
        src = pkgs.fetchFromGitHub {
          owner = "raspberrypi";
          repo = "linux";
          rev = "99972b2fa5395542e7c24e4d894be5ede383055f";
          hash = "sha256-Q7PEjEpnkeBevJduxSGFvtBQpRsFUqr2crDmbW3VyEU=";
        };
      };
    });

    kernelPatches = [
      # {
      #   name = "clockworkpi-kernel";
      #   patch = ./patches/clockworkpi-kernel.patch;
      # }
      {
        name = "clockworkpi-kernel";
        patch = ./patches/clockworkpi-kernel-min.patch;
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
        "ocp8178-bl" # Backlight driver
        "panel-clockwork-cwu50" # Display panel driver
        "simple-amplifier-switch" # Audio amplifier switch
      ];
    };

    # Disable Plymouth for cleaner boot process
    plymouth.enable = false;
  };

  # Firmware files specific to CM4
  hardware.firmware = with pkgs; [ linux-firmware ];
}
