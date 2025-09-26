{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # Import the SD image generator
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  # Boot configuration for Raspberry Pi CM4 with U-Boot
  boot = {
    loader = {
      # Use generic extlinux - U-Boot will read extlinux.conf
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
      timeout = 5;
    };

    # Critical: Disable systemd in initrd to match nixos-hardware approach
    initrd.systemd.tpm2.enable = false;
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

  # Manual SD card image configuration with full control and debugging
  sdImage = {
    # Use a reasonable image size
    imageName = "nixos-uconsole-rex-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.img";
    compressImage = false;

    # Partition sizes
    firmwareSize = 128; # MiB for firmware partition

    # Manual firmware population with complete control and debugging
    populateFirmwareCommands = let
      # Create our custom config.txt with all uConsole-specific settings
      configTxt = pkgs.writeText "config.txt" ''
        # Boot configuration for Raspberry Pi CM4
        [pi4]
        kernel=u-boot-rpi4.bin
        enable_gic=1
        armstub=armstub8-gic.bin
        
        [cm4]
        # CM4-specific settings
        arm_boost=1
        max_framebuffers=2
        
        [all]
        # Boot in 64-bit mode
        arm_64bit=1
        
        # U-Boot requirement
        enable_uart=1
        
        # Prevent firmware warnings from interfering with display
        avoid_warnings=1
        disable_overscan=1
        
        # uConsole-specific hardware configuration
        ignore_lcd=1
        disable_fw_kms_setup=1
        disable_audio_dither=1
        pwm_sample_bits=20
        
        # GPIO configuration for headphone detect
        gpio=10=ip,np
        
        # Device tree overlays
        dtoverlay=vc4-kms-v3d-pi4,cma-384
        dtoverlay=dwc2,dr_mode=host
        dtoverlay=audremap,pins_12_13
        dtoverlay=clockworkpi-uconsole
        
        # Parameters
        dtparam=audio=on
        dtparam=ant2
      '';
    in ''
      echo "=== MANUAL SD IMAGE GENERATION - FULL CONTROL ==="
      
      # Step 1: Create firmware directory with proper permissions
      echo "Step 1: Setting up firmware directory..."
      mkdir -p ./firmware
      chmod 755 ./firmware
      echo "✓ Firmware directory ready"
      
      # Step 2: Copy Raspberry Pi firmware files manually FIRST
      echo "Step 2: Copying Raspberry Pi firmware files..."
      firmware_src="${pkgs.raspberrypifw}/share/raspberrypi/boot"
      if [ -d "$firmware_src" ]; then
        cp -v "$firmware_src"/*.elf ./firmware/ 2>/dev/null || echo "No .elf files found"
        cp -v "$firmware_src"/*.dat ./firmware/ 2>/dev/null || echo "No .dat files found"
        cp -v "$firmware_src"/*.bin ./firmware/ 2>/dev/null || echo "No .bin files found"
        echo "✓ Firmware files copied from $firmware_src"
      else
        echo "⚠ WARNING: Firmware source not found at $firmware_src"
      fi
      
      # Step 3: Copy U-Boot files manually
      echo "Step 3: Copying U-Boot files..."
      uboot_rpi4="${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin"
      if [ -f "$uboot_rpi4" ]; then
        cp -v "$uboot_rpi4" ./firmware/u-boot-rpi4.bin
        chmod 644 ./firmware/u-boot-rpi4.bin
        echo "✓ U-Boot copied: $uboot_rpi4"
      else
        echo "⚠ WARNING: U-Boot not found at $uboot_rpi4"
      fi
      
      # Step 4: Create overlays directory and copy device tree overlays
      echo "Step 4: Setting up device tree overlays..."
      mkdir -p ./firmware/overlays
      
      # Copy standard overlays from raspberrypifw
      if [ -d "$firmware_src/../overlays" ]; then
        cp -v "$firmware_src"/../overlays/*.dtbo ./firmware/overlays/ 2>/dev/null || echo "No standard overlays found"
        echo "✓ Standard overlays copied"
      fi
      
      # Copy custom overlays from our kernel build
      kernel_overlays="${config.boot.kernelPackages.kernel}/dtbs/overlays"
      if [ -d "$kernel_overlays" ]; then
        echo "Copying custom kernel overlays from: $kernel_overlays"
        cp -v "$kernel_overlays"/*.dtbo ./firmware/overlays/ 2>/dev/null || echo "No custom overlays found"
        echo "✓ Custom kernel overlays copied"
      else
        echo "⚠ WARNING: No custom overlays directory at $kernel_overlays"
        echo "Available kernel dtbs structure:"
        find ${config.boot.kernelPackages.kernel}/dtbs -type d 2>/dev/null || echo "No dtbs directory found"
      fi
      
      # Step 5: Verify our critical overlay is present
      echo "Step 5: Verifying critical overlays..."
      if [ -f "./firmware/overlays/clockworkpi-uconsole.dtbo" ]; then
        echo "✓ SUCCESS: clockworkpi-uconsole.dtbo found!"
        ls -la ./firmware/overlays/clockworkpi-uconsole.dtbo
      else
        echo "❌ ERROR: clockworkpi-uconsole.dtbo NOT FOUND"
        echo "Available overlays containing 'clockworkpi' or 'uconsole':"
        ls -la ./firmware/overlays/ | grep -i -E "(clockworkpi|uconsole)" || echo "None found"
      fi
      
      # Step 6: Install our custom config.txt
      echo "Step 6: Installing custom config.txt..."
      cp -v ${configTxt} ./firmware/config.txt
      chmod 644 ./firmware/config.txt
      echo "✓ Custom config.txt installed"
      
      # Step 7: Install bootloader configuration (LAST to avoid permission issues)
      echo "Step 7: Installing bootloader configuration..."
      ${config.system.build.installBootLoader} ${config.system.build.toplevel} -d ./firmware
      echo "✓ Bootloader configuration installed"
      
      # Step 8: Final verification
      echo "Step 8: Final verification..."
      echo "Firmware directory contents:"
      ls -la ./firmware/
      echo ""
      echo "Overlay count: $(ls ./firmware/overlays/ | wc -l)"
      echo "Config.txt preview:"
      head -20 ./firmware/config.txt
      
      echo "=== MANUAL SD IMAGE GENERATION COMPLETE ==="
    '';

    # Root partition configuration
    populateRootCommands = ''
      mkdir -p ./files/boot
    '';
  };
}
