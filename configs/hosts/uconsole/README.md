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

## Build Strategy: QEMU Emulation

This configuration uses **QEMU emulation via binfmt** for ARM64 builds on x86_64 systems.

### Current Setup:
```nix
# On build host (hades):
boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
nix.settings.extra-platforms = [ "aarch64-linux" ];
```

### Why QEMU Emulation:
- **Full Compatibility**: All packages build correctly without cross-compilation issues
- **Kernel Support**: Complex kernel builds with custom patches work reliably  
- **No Package Limitations**: Avoids cross-compilation failures for complex dependencies
- **Upstream Testing**: Packages are tested in the same ARM environment as target
- **Diagnostic Mode**: Currently running diagnostics to identify missing files

### Build Performance:
- **Kernel builds**: ~15-30 minutes (acceptable for development)
- **System rebuilds**: Slower but reliable
- **Trade-off**: Prioritizes reliability over speed for complex custom kernel work

### Current Focus:
The boot configuration is in **diagnostic mode** to identify which firmware and overlay files are available vs missing, allowing us to create a targeted firmware population strategy.

## Configuration Modules

### `configuration.nix` - Main Entry Point

**Current State:**
- Imports Rex kernel configuration (`./kernels/rex/`)
- nixos-hardware Raspberry Pi module **temporarily disabled** for manual SD image control
- Essential Pi 4 hardware support manually configured in individual modules
- Includes overlay fix for missing firmware issues (`makeModulesClosure` hack)

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

### `kernels/rex/boot.nix` - Diagnostic Mode SD Image Generation

**Current Mode: DIAGNOSTIC**
The boot configuration is currently in **diagnostic mode** to identify missing files rather than attempting to copy them. This provides:

**Diagnostic Process:**
1. **Check Raspberry Pi firmware availability** (start*.elf, fixup*.dat files)
2. **Verify U-Boot binary location** (`u-boot-rpi4.bin`)
3. **Scan standard device tree overlays** from raspberrypifw package
4. **Search custom kernel overlays** (including `clockworkpi-uconsole.dtbo`)
5. **Report missing vs available files** with detailed logging
6. **Generate file availability report** for targeted fixes

**Critical Pi 4 Boot Configuration:**
```nix
boot = {
  loader.generic-extlinux-compatible.enable = true;
  # Critical: Disable TPM2 (Pi 4 doesn't have TPM2 hardware)
  initrd.systemd.tpm2.enable = false;
};
```

**Diagnostic Benefits:**
- **No permission errors** - no file copying attempted
- **Complete visibility** - shows exactly what files exist where
- **Targeted fixes** - identifies specific missing components
- **Build success** - diagnostic builds complete without file operation failures

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
- Default hostname: `uconsole`
- NetworkManager enabled for easier network management
- Console tools: `fbset`, `kmscon` for framebuffer support

## Hardware Support Status

- ✅ **Custom Kernel**: 6.12.48 Raspberry Pi kernel with uConsole patches applied
- ✅ **QEMU Emulation**: Reliable builds via binfmt with full package compatibility
- ✅ **Critical Pi 4 Support**: USB, GPU, PCIe, device tree, firmware all configured
- ✅ **Boot Configuration**: TPM2 disabled, extlinux configured for Pi 4
- ✅ **Serial Console**: UART debugging available
- ✅ **Networking**: WiFi via NetworkManager with proper firmware support
- ✅ **Hardware Drivers**: Display, backlight, PMU drivers compiled and available
- 🔍 **Diagnostic Mode**: Currently identifying available vs missing firmware files
- 🚧 **Device Tree Overlay**: Verifying `clockworkpi-uconsole.dtbo` availability and loading
- 🚧 **Hardware Detection**: Testing overlay loading and peripheral detection
- 🚧 **USB Functionality**: Verifying USB host mode and device detection  
- ⏳ **Display Output**: Pending successful boot and hardware initialization
- ⏳ **Audio**: Pending overlay loading and hardware setup
- ⏳ **Power Management**: Pending AXP PMU detection and battery monitoring

## Current Development Focus

### 1. Diagnostic Phase - File Availability Assessment
- **Current Task**: Running comprehensive diagnostics to identify missing firmware files
- **Status**: 🔍 Boot configuration in diagnostic mode
- **Goal**: Generate complete report of available vs missing files
- **Next**: Use diagnostic results to create targeted file copying strategy

### 2. Device Tree Overlay Verification  
- **Issue**: Confirming `clockworkpi-uconsole.dtbo` is built and accessible
- **Status**: 🚧 Checking kernel overlay build output and location
- **Dependencies**: Kernel patch must generate ARM64 overlay successfully
- **Testing**: Diagnostic mode will show exact overlay availability

### 3. Firmware Population Strategy
- **Current Approach**: Diagnostic-first to avoid permission and missing file issues
- **Benefits**: No build failures, complete visibility into available components  
- **Next Phase**: Convert successful diagnostic results into targeted copying
- **Goal**: Transition from diagnostic mode to working firmware population

## Building the SD Image (Diagnostic Mode)

```bash
cd /home/gideon/nix
nix build .#nixosConfigurations.uconsole-rex.config.system.build.sdImage
```

**Current Behavior:**
- Build completes successfully (no file copying errors)
- Generates comprehensive firmware availability report  
- Shows exact file locations and missing components
- Creates minimal diagnostic config.txt

## Diagnostic Output

The diagnostic build process provides comprehensive analysis:
- ✅ **Firmware availability check**: Lists all .elf, .dat, .bin files from raspberrypifw
- ✅ **U-Boot verification**: Confirms U-Boot binary location and accessibility
- ✅ **Standard overlays scan**: Counts and lists all standard Pi device tree overlays  
- ✅ **Custom kernel overlays**: Searches for uConsole-specific overlays in kernel build
- ✅ **Critical files status**: Reports on essential boot components (start4.elf, etc.)
- ✅ **Package version info**: Shows firmware, U-Boot, and kernel versions
- ✅ **Missing file identification**: Clearly identifies what's not found

## Next Steps

1. **Run Diagnostic Build**: Execute build and analyze firmware availability report
2. **Identify Missing Files**: Review diagnostic output for missing critical components
3. **Create Targeted Fixes**: Based on diagnostic results, implement specific file copying
4. **Test Hardware Boot**: Once firmware population works, test on actual uConsole hardware
5. **Verify Overlays**: Confirm device tree overlays load and hardware is detected

## Sources and References

### Technical Documentation
- **NixOS on ARM Wiki**: [nixos.wiki/wiki/NixOS_on_ARM](https://nixos.wiki/wiki/NixOS_on_ARM) - Build strategies, supported devices
- **NixOS Manual - Cross Compilation**: Building for different architectures
- **Raspberry Pi Documentation**: [rptl.io](https://rptl.io) - Official Pi 4/CM4 hardware documentation

### Code References  
- **Kernel**: [Raspberry Pi Linux](https://github.com/raspberrypi/linux) official kernel
- **uConsole Patches**: Based on ClockworkPi and community kernel modifications  
- **Manual SD Approach**: Inspired by [robertjakub/oom-hardware](https://github.com/robertjakub/oom-hardware/tree/main/uconsole)
- **Previous Work**: [voidcontext/nixos-uconsole](https://github.com/voidcontext/nixos-uconsole) for hardware understanding
- **nixos-hardware**: [nixos-hardware/raspberry-pi](https://github.com/NixOS/nixos-hardware/tree/master/raspberry-pi) - Upstream Pi 4 configuration

### Community Resources
- **Matrix Chat**: [#nixos-on-arm:nixos.org](https://matrix.to/#/#nixos-on-arm:nixos.org) - NixOS ARM community support
- **NixOS Discourse**: ARM and embedded systems discussions

## Contributing

When modifying this configuration:

1. Test changes incrementally on actual hardware
2. Document any new kernel patches or hardware findings
3. Update this README with configuration changes
4. Use the manual SD image approach for debugging new features

## License

This configuration is provided as-is for educational and development purposes. Refer to individual component licenses for specific terms.
