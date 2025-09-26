# uConsole NixOS Configuration

This directory contains a NixOS configuration for the ClockworkPi uConsole, a handheld Linux computer based on the Raspberry Pi CM4.

## Current Status (September 2025)

**⚠️ Work in Progress**: This configuration is actively being developed. We're currently using a **manual SD image generation approach** to debug and resolve overlay loading issues.

**Key Issues Being Resolved:**
- Device tree overlay loading for custom hardware
- USB and hardware peripheral functionality  
- Firmware population and boot partition setup

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

## Current Approach: Manual SD Image Generation

We're using a **manual, step-by-step SD image generation approach** (inspired by [robertjakub/oom-hardware](https://github.com/robertjakub/oom-hardware)) rather than relying on nixos-hardware modules. This gives us complete control and visibility into the build process.

### Why Manual Control?

1. **Debugging**: Each step is logged and can be inspected
2. **Overlay Verification**: Explicit checking for `clockworkpi-uconsole.dtbo`  
3. **Firmware Control**: Manual copying of all firmware components
4. **No Module Conflicts**: Avoids conflicts between nixos-hardware and custom config

## Configuration Modules

### `configuration.nix` - Main Entry Point

**Current State:**
- Imports Rex kernel configuration (`./kernels/rex/`)
- nixos-hardware Raspberry Pi module **temporarily disabled** for manual control
- Includes overlay fix for missing firmware issues

### `kernels/rex/kernel.nix` - Custom Kernel with uConsole Support

**Kernel Version:** 6.12.48 (Raspberry Pi official kernel)
- **Source**: `raspberrypi/linux` commit `99972b2fa5395542e7c24e4d894be5ede383055f`  
- **Key Patch**: `clockworkpi-kernel-renamed-overlay.patch` - Adds device tree overlay support

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

**Active Configuration:**
```nix
hardware = {
  enableRedistributableFirmware = true;
  deviceTree.enable = true;
  i2c.enable = true;
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
