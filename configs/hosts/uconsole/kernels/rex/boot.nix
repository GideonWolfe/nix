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
      echo "=== DIAGNOSTIC MODE - FILE AVAILABILITY CHECK ==="
      
      # Step 1: Create firmware directory structure
      echo "Step 1: Setting up directory structure for diagnostics..."
      mkdir -p ./firmware/overlays
      chmod 755 ./firmware ./firmware/overlays
      echo "✓ Directory structure ready"
      
      # Step 2: Check Raspberry Pi firmware availability
      echo "Step 2: Checking Raspberry Pi firmware files..."
      firmware_src="${pkgs.raspberrypifw}/share/raspberrypi/boot"
      echo "Firmware source path: $firmware_src"
      
      if [ -d "$firmware_src" ]; then
        echo "✓ Firmware directory exists"
        echo "Available .elf files:"
        find "$firmware_src" -name "*.elf" -exec basename {} \; 2>/dev/null | sort || echo "  None found"
        echo ""
        echo "Available .dat files:"
        find "$firmware_src" -name "*.dat" -exec basename {} \; 2>/dev/null | sort || echo "  None found"
        echo ""
        echo "Available .bin files:"
        find "$firmware_src" -name "*.bin" -exec basename {} \; 2>/dev/null | sort || echo "  None found"
        echo ""
        echo "Complete firmware directory contents:"
        ls -la "$firmware_src"
      else
        echo "❌ Firmware directory NOT FOUND at $firmware_src"
      fi
      
      # Step 3: Check U-Boot availability
      echo ""
      echo "Step 3: Checking U-Boot files..."
      uboot_rpi4="${pkgs.ubootRaspberryPi4_64bit}/u-boot.bin"
      echo "U-Boot path: $uboot_rpi4"
      if [ -f "$uboot_rpi4" ]; then
        echo "✓ U-Boot found"
        ls -la "$uboot_rpi4"
      else
        echo "❌ U-Boot NOT FOUND"
        echo "Checking U-Boot package contents:"
        find "${pkgs.ubootRaspberryPi4_64bit}" -name "*.bin" 2>/dev/null | head -10 || echo "  No .bin files found"
      fi
      
      # Step 4: Check standard overlay availability  
      echo ""
      echo "Step 4: Checking standard device tree overlays..."
      overlays_src="$firmware_src/../overlays"
      echo "Standard overlays path: $overlays_src"
      if [ -d "$overlays_src" ]; then
        echo "✓ Standard overlays directory exists"
        overlay_count=$(find "$overlays_src" -name "*.dtbo" | wc -l)
        echo "Total standard overlays: $overlay_count"
        echo ""
        echo "Standard overlays containing 'clockworkpi' or 'uconsole':"
        find "$overlays_src" -name "*.dtbo" -exec basename {} \; | grep -i -E "(clockworkpi|uconsole)" || echo "  None found"
        echo ""
        echo "First 20 standard overlays:"
        find "$overlays_src" -name "*.dtbo" -exec basename {} \; | sort | head -20
      else
        echo "❌ Standard overlays directory NOT FOUND"
      fi
      
      # Step 5: Check custom kernel overlays
      echo ""
      echo "Step 5: Checking custom kernel overlays..."
      kernel_overlays="${config.boot.kernelPackages.kernel}/dtbs/overlays"
      echo "Kernel overlays path: $kernel_overlays"
      if [ -d "$kernel_overlays" ]; then
        echo "✓ Kernel overlays directory exists"
        custom_overlay_count=$(find "$kernel_overlays" -name "*.dtbo" | wc -l)
        echo "Total custom overlays: $custom_overlay_count"
        echo ""
        echo "Custom overlays:"
        find "$kernel_overlays" -name "*.dtbo" -exec basename {} \; | sort || echo "  None found"
        echo ""
        echo "Custom overlays containing 'clockworkpi' or 'uconsole':"
        find "$kernel_overlays" -name "*.dtbo" -exec basename {} \; | grep -i -E "(clockworkpi|uconsole)" || echo "  None found"
      else
        echo "❌ Kernel overlays directory NOT FOUND"
        echo "Available kernel dtbs structure:"
        find "${config.boot.kernelPackages.kernel}/dtbs" -type d 2>/dev/null || echo "  No dtbs directory found"
        echo ""
        echo "Looking for overlays anywhere in kernel package:"
        find "${config.boot.kernelPackages.kernel}" -name "*.dtbo" 2>/dev/null | head -10 || echo "  No .dtbo files found anywhere"
      fi
      
      # Step 6: Check for armstub files
      echo ""
      echo "Step 6: Checking for armstub files..."
      echo "Looking for armstub8-gic.bin in firmware:"
      find "$firmware_src" -name "armstub*" 2>/dev/null || echo "  No armstub files found"
      
      # Step 7: Package version information
      echo ""
      echo "Step 7: Package version information..."
      echo "Raspberry Pi firmware version: ${pkgs.raspberrypifw.version or "unknown"}"
      echo "U-Boot version: ${pkgs.ubootRaspberryPi4_64bit.version or "unknown"}"
      echo "Kernel version: ${config.boot.kernelPackages.kernel.version or "unknown"}"
      
      # Step 8: Critical files summary
      echo ""
      echo "Step 8: Critical files availability summary..."
      echo "=== REQUIRED FILES STATUS ==="
      
      critical_files=(
        "$firmware_src/start4.elf:Raspberry Pi GPU firmware"
        "$firmware_src/fixup4.dat:GPU memory split config"  
        "$uboot_rpi4:U-Boot bootloader"
        "$overlays_src/vc4-kms-v3d.dtbo:Standard GPU overlay"
        "$kernel_overlays/clockworkpi-uconsole.dtbo:Custom uConsole overlay"
      )
      
      for file_info in "''${critical_files[@]}"; do
        file_path="''${file_info%%:*}"
        description="''${file_info#*:}"
        if [ -f "$file_path" ]; then
          echo "✓ FOUND: $description"
          ls -la "$file_path"
        else
          echo "❌ MISSING: $description"
          echo "   Expected at: $file_path"
        fi
      done
      
      # Step 9: Create minimal config.txt for now
      echo ""
      echo "Step 9: Creating minimal diagnostic config.txt..."
      echo "# Diagnostic config.txt - files checked but not copied" > ./firmware/config.txt
      echo "# This build was run in diagnostic mode" >> ./firmware/config.txt
      echo "✓ Diagnostic config.txt created"
      
      echo ""
      echo "=== DIAGNOSTIC MODE COMPLETE ==="
      echo "Review the output above to identify missing files"
    '';

    # Root partition configuration
    populateRootCommands = ''
      mkdir -p ./files/boot
    '';
  };
}
