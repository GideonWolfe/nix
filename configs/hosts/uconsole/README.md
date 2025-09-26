# uConsole NixOS Configuration

This directory contains a NixOS configuration for the ClockworkPi uConsole, a handheld Linux computer based on the Raspberry Pi CM4.

## Current Status (September 2025)

**✅ Active Development**: This configuration now includes **essential Raspberry Pi 4 hardware support** while maintaining **manual SD image generation** for complete control and debugging.

**Current Approach:**
- **Manual SD image generation** with step-by-step firmware population
- **Critical Pi 4 hardware support** restored (USB, GPU, PCIe, device tree)
- **Custom uConsole kernel** with device tree overlays
- **Full debugging visibility** into build and boot process

**Key Issues Being Resolved:**
- ✅ Essential Pi 4 hardware functionality (USB, GPU, firmware)
- 🚧 Device tree overlay loading for custom uConsole hardware
- 🚧 Hardware peripheral detection and functionality
- 🚧 Display, audio, and power management integration

## Architecture Overview

The configuration follows a modular approach with separation of concerns:

```
configs/hosts/uconsole/
├── configuration.nix          # Main entry point, imports all modules
├── hardware.nix              # Hardware-specific settings (I2C, Bluetooth, etc.)
├── hardware-configuration.nix # Auto-generated hardware config
├── system.nix                # System packages, users, networking
└── kernels/rex/              # Rex kernel configuration
    ├── kernel.nix            # Custom kernel with uConsole patches
    ├── boot.nix              # Manual SD image generation
    └── patches/              # Kernel patches directory
        └── clockworkpi-kernel-renamed-overlay.patch
```

## Current Approach: Hybrid Manual + Essential Hardware Support

We're using a **hybrid approach** that combines:
1. **Essential Pi 4 hardware support** from nixos-hardware (USB, GPU, firmware, device tree)
2. **Manual SD image generation** for complete firmware control and debugging visibility

### Why This Hybrid Approach?

1. **Critical Hardware Support**: Ensures USB, GPU, PCIe, and other Pi 4 essentials work
2. **Manual Firmware Control**: Complete visibility and control over SD image generation
3. **Debugging**: Each step is logged and can be inspected
4. **Overlay Verification**: Explicit checking for `clockworkpi-uconsole.dtbo`  
5. **No nixos-hardware Conflicts**: Manual firmware population avoids config.txt conflicts

## Configuration Modules

### `configuration.nix` - Main Entry Point

**Current State:**
- Imports Rex kernel configuration (`./kernels/rex/`)
- nixos-hardware Raspberry Pi module **temporarily disabled** for manual SD image control
- Essential Pi 4 hardware support manually configured in individual modules
- Includes overlay fix for missing firmware issues

### `hardware.nix` - Hardware Configuration

**Current State:**
- **Essential Pi 4 Support**: Critical hardware functionality restored
  - Device tree filtering: `bcm2711-rpi-*.dtb` (ensures correct Pi 4/CM4 device tree)
  - Redistributable firmware: WiFi/Bluetooth firmware support
  - I2C and Bluetooth enabled for uConsole peripherals
- **nixos-hardware raspberry-pi."4" section disabled** to avoid SD image conflicts
- Power management with upower and battery monitoring

### `kernels/rex/kernel.nix` - Custom Kernel with uConsole Support

**Kernel Version:** 6.12.48 (Raspberry Pi official kernel)
- **Source**: `raspberrypi/linux` commit `99972b2fa5395542e7c24e4d894be5ede383055f`  
- **Key Patch**: `clockworkpi-kernel-renamed-overlay.patch` - Adds device tree overlay support

**Critical Pi 4 Boot Support:**
```nix
initrd.availableKernelModules = [
  "usbhid"             # USB input devices  
  "usb_storage"        # USB storage
  "vc4"                # VideoCore GPU driver
  "pcie_brcmstb"       # PCIe bus (essential for peripherals)
  "reset-raspberrypi"  # VL805 firmware loading
];
```

**Hardware Drivers Enabled:**
- `DRM_PANEL_CWU50` - Display panel driver
- `BACKLIGHT_OCP8178` - Backlight controller  
- Power management (AXP20x PMU, regulators, ADC)
- I2C and sensor support

**Boot Modules:**
```nix
kernelModules = [
  "i2c-dev"      # I2C device access
  "spi-dev"      # SPI device access  
  "gpio-dev"     # GPIO access
];

initrd.kernelModules = [
  "vc4"          # VideoCore GPU
  "bcm2835_dma"  # DMA controller
];
```

### `kernels/rex/boot.nix` - Manual SD Image Generation

**Manual Firmware Population Process:**
1. **Create firmware directory** with proper permissions
2. **Copy Raspberry Pi firmware** (bootcode.bin, start*.elf, fixup*.dat)
3. **Copy U-Boot** (`u-boot-rpi4.bin`)  
4. **Copy device tree overlays** (including `clockworkpi-uconsole.dtbo`)
5. **Install custom config.txt** with uConsole hardware settings
6. **Install bootloader configuration** (extlinux.conf)
7. **Verify all components** with detailed logging

**Critical Pi 4 Boot Configuration:**
```nix
boot = {
  loader.generic-extlinux-compatible.enable = true;
  # Critical: Disable TPM2 (Pi 4 doesn't have TPM2 hardware)
  initrd.systemd.tpm2.enable = false;
};
```

**Key config.txt Settings:**
```ini
[pi4]
kernel=u-boot-rpi4.bin
enable_gic=1
armstub=armstub8-gic.bin

[all]  
arm_64bit=1
enable_uart=1
ignore_lcd=1
disable_fw_kms_setup=1
disable_audio_dither=1
pwm_sample_bits=20
gpio=10=ip,np

# Device tree overlays
dtoverlay=clockworkpi-uconsole
dtoverlay=dwc2,dr_mode=host  
dtoverlay=audremap,pins_12_13
dtoverlay=vc4-kms-v3d,cma-384

# Parameters
dtparam=audio=on
dtparam=ant2=on
```

### `hardware.nix` - Hardware Configuration

**Current State:**
- Basic hardware support (device tree, I2C, Bluetooth)
- **raspberry-pi."4" configuration temporarily disabled** for manual control
- Power management with upower and battery monitoring

### `hardware.nix` - Hardware Configuration

**Current State:**
- **Essential Pi 4 Support**: Critical hardware functionality restored
  - Device tree filtering: `bcm2711-rpi-*.dtb` (ensures correct Pi 4/CM4 device tree)
  - Redistributable firmware: WiFi/Bluetooth firmware support
  - I2C and Bluetooth enabled for uConsole peripherals
- **nixos-hardware raspberry-pi."4" section disabled** to avoid SD image conflicts
- Power management with upower and battery monitoring

**Active Configuration:**
```nix
hardware = {
  enableRedistributableFirmware = true;  # WiFi/Bluetooth firmware
  deviceTree = {
    enable = true;
    filter = "bcm2711-rpi-*.dtb";        # Pi 4/CM4 device tree selection
  };
  i2c.enable = true;                     # uConsole I2C peripherals
  bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
};
```

### `system.nix` - System Configuration  

**Essential uConsole Packages:**
- **Hardware Tools**: `i2c-tools`, `libraspberrypi`, `raspberrypi-eeprom`
- **Debugging**: `usbutils`, `pciutils`, `lshw`, `htop`
- **Development**: `vim`, `git`, `curl`, `screen`, `tmux`

**User Setup:**
- Default user: `uconsole` with hardware access groups

## Hardware Support Status

- ✅ **Custom Kernel**: 6.12.48 Raspberry Pi kernel with uConsole patches applied
- ✅ **Critical Pi 4 Support**: USB, GPU, PCIe, device tree, firmware all configured
- ✅ **Device Tree Overlay**: `clockworkpi-uconsole.dtbo` builds successfully (6206 bytes)
- ✅ **Manual SD Image**: Step-by-step firmware population with full control
- ✅ **Boot Configuration**: TPM2 disabled, extlinux configured for Pi 4
- ✅ **Serial Console**: UART debugging available
- ✅ **Networking**: WiFi via NetworkManager with proper firmware support
- ✅ **Hardware Drivers**: Display, backlight, PMU drivers compiled and available
- 🚧 **Hardware Detection**: Testing overlay loading and peripheral detection
- 🚧 **USB Functionality**: Verifying USB host mode and device detection  
- ⏳ **Display Output**: Pending successful boot and hardware initialization
- ⏳ **Audio**: Pending overlay loading and hardware setup
- ⏳ **Power Management**: Pending AXP PMU detection and battery monitoring

## Current Development Focus

### 1. Device Tree Overlay Loading
- **Issue**: Ensuring `clockworkpi-uconsole.dtbo` is built and loaded
- **Status**: ✅ Overlay is being built successfully (6206 bytes)
- **Next**: Verify it loads at boot and enables hardware

### 2. Firmware Population
- **Issue**: Manual control over firmware copying vs nixos-hardware conflicts  
- **Status**: ✅ Manual copying working, permission issues resolved
- **Approach**: Step-by-step verification with detailed logging

### 3. Hardware Functionality
- **Target**: USB, audio, display, power management working
- **Blocker**: Device tree overlay must load properly
- **Testing**: Boot on hardware and verify peripheral detection

## Building the SD Image

```bash
cd /home/gideon/nix
nix build .#nixosConfigurations.uconsole-rex.config.system.build.sdImage
```

The build process will show detailed step-by-step output for each firmware population phase.

## Debugging Output

The manual build process includes extensive debugging output:
- ✅ Firmware file copying verification  
- ✅ U-Boot installation confirmation
- ✅ Device tree overlay presence checking
- ✅ Config.txt content validation
- ✅ Final directory structure listing

## Next Steps

1. **Test Hardware Boot**: Flash SD image and boot on actual uConsole hardware
2. **Verify Overlays**: Confirm device tree overlays load and hardware is detected  
3. **Enable Features**: Gradually re-enable display, audio, and other features
4. **Re-enable nixos-hardware**: Once working, optionally switch back to nixos-hardware approach

## Sources and References

- **Kernel**: [Raspberry Pi Linux](https://github.com/raspberrypi/linux) official kernel
- **uConsole Patches**: Based on ClockworkPi and community kernel modifications  
- **Manual SD Approach**: Inspired by [robertjakub/oom-hardware](https://github.com/robertjakub/oom-hardware/tree/main/uconsole)
- **Previous Work**: [voidcontext/nixos-uconsole](https://github.com/voidcontext/nixos-uconsole) for hardware understanding

## Contributing

When modifying this configuration:

1. Test changes incrementally on actual hardware
2. Document any new kernel patches or hardware findings
3. Update this README with configuration changes
4. Use the manual SD image approach for debugging new features

## License

This configuration is provided as-is for educational and development purposes. Refer to individual component licenses for specific terms.
