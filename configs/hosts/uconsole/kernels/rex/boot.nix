{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # Import the SD image generator
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  # Boot configuration for Raspberry Pi CM4
  boot.loader = {
    # Use the extlinux boot loader for ARM
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

    # Include firmware files with config.txt
    populateFirmwareCommands = let
      configTxt = pkgs.writeText "config.txt" ''
        [pi4]
        dtoverlay=clockworkpi-uconsole
        dtoverlay=vc4-kms-v3d-pi4,cma-384
        enable_uart=1

        [all]
        ignore_lcd=1
        max_framebuffers=2
        disable_overscan=1
        dtparam=audio=on
        dtoverlay=audremap,pins_12_13
        dtoverlay=dwc2,dr_mode=host
        dtparam=ant2
      '';
    in ''
      ${config.system.build.installBootLoader} ${config.system.build.toplevel} -d ./firmware

      # Add the config
      rm -f firmware/config.txt
      cp ${configTxt} firmware/config.txt
    '';

    # Root partition configuration
    populateRootCommands = ''
      mkdir -p ./files/boot
    '';
  };
}
