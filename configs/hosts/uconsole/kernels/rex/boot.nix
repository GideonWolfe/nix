{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # Import the SD image generator
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  # Boot configuration for Raspberry Pi CM4 with U-Boot
  boot.loader = {
    # Use generic extlinux - U-Boot will read extlinux.conf
    generic-extlinux-compatible.enable = true;
    grub.enable = false;
    timeout = 5;
  };

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
  swapDevices = [{
    device = "/swapfile";
    size = 1024; # 1GB swap
  }];

  # SD card image configuration with uConsole-specific boot config
  sdImage = {
    # Use a reasonable image size
    imageName =
      "nixos-uconsole-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.img";
    compressImage = false;

    # Partition sizes
    firmwareSize = 128; # MiB for firmware partition

    # Include firmware files with config.txt for U-Boot
    populateFirmwareCommands = let
      configTxt = pkgs.writeText "config.txt" ''
        [pi4]
        kernel=u-boot-rpi4.bin
        enable_gic=1
        armstub=armstub8-gic.bin
        
        # uConsole specific overlays
        dtoverlay=clockworkpi-uconsole
        dtoverlay=vc4-kms-v3d-pi4,cma-384
        enable_uart=1

        [all]
        # Boot in 64-bit mode
        arm_64bit=1
        
        # U-Boot requirement
        enable_uart=1
        
        # Prevent firmware warnings
        avoid_warnings=1
        
        # uConsole display and hardware config
        ignore_lcd=1
        max_framebuffers=2
        disable_overscan=1
        dtparam=audio=on
        dtoverlay=audremap,pins_12_13
        dtoverlay=dwc2,dr_mode=host
        dtparam=ant2
      '';
    in ''
      # Install the bootloader configuration first (extlinux.conf for U-Boot to read)
      ${config.system.build.installBootLoader} ${config.system.build.toplevel} -d ./firmware
      
      # Remove any existing firmware files and copy fresh ones (with proper permissions)
      rm -f firmware/*.bin firmware/*.dat firmware/*.elf || true
      
      # Copy Raspberry Pi firmware files
      cp -v ${pkgs.raspberrypifw}/share/raspberrypi/boot/*.bin firmware/ || true
      cp -v ${pkgs.raspberrypifw}/share/raspberrypi/boot/*.dat firmware/ || true
      cp -v ${pkgs.raspberrypifw}/share/raspberrypi/boot/*.elf firmware/ || true
      
      # Make sure we can overwrite any existing u-boot file
      rm -f firmware/u-boot-rpi4.bin || true
      # Copy U-Boot
      cp -v ${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin firmware/u-boot-rpi4.bin
      
      # Remove any existing config.txt and copy our custom one
      # possibly not needed
      rm -f firmware/config.txt || true

      # Copy our config.txt (overwriting any existing one)
      cp ${configTxt} firmware/config.txt
    '';

    # Root partition configuration
    populateRootCommands = ''
      mkdir -p ./files/boot
    '';
  };
}
