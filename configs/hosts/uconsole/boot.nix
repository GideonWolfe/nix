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
  swapDevices = [
    {
      device = "/swapfile";
      size = 1024; # 1GB swap
    }
  ];

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
          # Basic Raspberry Pi CM4 configuration
          [all]
          # Boot in 64-bit mode
          arm_64bit=1
          
          # U-Boot needs this to work, regardless of whether UART is actually used or not
          enable_uart=1
          
          # Prevent the firmware from smashing the framebuffer setup done by the mainline kernel
          # when attempting to show low-voltage or overtemperature warnings
          avoid_warnings=1
          
          # Basic display - HDMI for debugging  
          hdmi_force_hotplug=1
          hdmi_drive=2
          
          # Simple framebuffer
          framebuffer_width=1280
          framebuffer_height=720
          
          # Basic GPU support
          gpu_mem=128
          
          # ---- uConsole-specific settings (commented for basic boot testing) ----
          # [pi3]
          # kernel=u-boot-rpi3.bin
          
          # [pi4]
          # kernel=u-boot-rpi4.bin
          # enable_gic=1
          # armstub=armstub8-gic.bin
          # disable_overscan=1
          # arm_boost=1
          
          # [cm4]
          # arm_boost=1
          # max_framebuffers=2
          # dtoverlay=vc4-kms-v3d-pi4,cma-384
          # ignore_lcd=1
          # disable_fw_kms_setup=1
          # disable_audio_dither
          # pwm_sample_bits=20
          # gpio=10=ip,np
          # dtoverlay=dwc2,dr_mode=host
          # dtoverlay=audremap,pins_12_13
          # dtparam=audio=on
          # dtparam=ant2
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
