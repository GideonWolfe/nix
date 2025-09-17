# uConsole NixOS Configuration

This directory contains a modular NixOS configuration for the ClockworkPi uConsole, a handheld Linux computer based on the Raspberry Pi CM4.

## Overview

The configuration is split into focused modules to separate concerns and improve maintainability. Each module handles a specific aspect of the uConsole hardware or system configuration.

### `patches/` - Kernel Patches Directory

Contains the kernel patches required to enable uConsole-specific hardware. These patches add drivers and modify existing drivers to work with the uConsole's custom components.

**Patch Files:**

1. **`0001-video-backlight-Add-OCP8178-backlight-driver.patch`**
   - Adds kernel driver for the OCP8178 backlight controller
   - Enables brightness control for the 5-inch display

2. **`0002-drm-panel-add-clockwork-cwu50.patch`**
   - Adds DRM panel driver for the Clockwork CWU50 display
   - Handles DSI communication and panel initialization

3. **`0003-driver-staging-add-uconsole-simple-amplifier-switch.patch`**
   - Adds audio amplifier switching driver
   - Controls audio routing between internal speaker and headphone jack

4. **`0005-drivers-power-axp20x-customize-PMU.patch`**
   - Customizes the AXP20x power management driver for uConsole
   - Improves power management and battery handling

5. **`0006-power-axp20x_battery-implement-calibration.patch`**
   - Implements battery calibration for more accurate charge reporting
   - Essential for proper battery monitoring

6. **`0007-drm-panel-cwu50-expose-dsi-error-status-to-userspace.patch`**
   - Exposes DSI error status to userspace for debugging
   - Helps diagnose display communication issues

**Sources:**
- All patches sourced from [PotatoMania's uConsole CM3 project](https://github.com/PotatoMania/uconsole-cm3)
- Originally integrated in [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)
- Patches are applied automatically by the kernel module configuration

**Note:** Patch `0004-arm-dts-overlays-add-uconsole.patch` is not used as we implement device tree overlays through NixOS's `hardware.deviceTree` configuration instead.

## Configuration Modules

### `configuration.nix` - Main Configuration Entry Point

The main configuration file that imports all other modules and sets up the basic NixOS structure.

**Key Features:**
- Imports the SD image generator for ARM64
- Includes the base profile for minimal system requirements
- Applies a nixpkgs overlay to fix missing firmware issues
- Coordinates all uConsole-specific modules

**Sources:**
- Based on standard NixOS ARM64 SD image configuration
- Overlay hack from various Raspberry Pi NixOS configurations to handle firmware issues

### `kernel.nix` - Kernel Configuration

Contains the uConsole-specific kernel configuration with hardware-enabling patches.

**Key Features:**

- **Custom Kernel Package**: Uses the same 6.1.63 kernel source from the `nixos-uconsole` project
  - Based on Raspberry Pi's `stable_20231123` kernel tree
  - Specifically tested to work with uConsole CM4 hardware
  
- **Hardware-Enabling Patches**: Applies essential patches for uConsole functionality:
  - **OCP8178 Backlight Driver**: Controls the display backlight
  - **Clockwork CWU50 Panel Driver**: Enables the 5-inch display panel
  - **Simple Amplifier Switch**: Controls audio amplifier switching
  - **AXP20x PMU Customization**: Power management improvements
  - **AXP20x Battery Calibration**: Better battery reporting
  - **CWU50 DSI Error Status**: Display debugging capabilities

- **Kernel Configuration**: Enables all required kernel options for:
  - Power management (AXP20x drivers, regulators)
  - Display support (DRM panel drivers)
  - I2C and SPI communication
  - Audio amplifier control
  - ADC support for sensors

- **Boot Modules**: Automatically loads uConsole-specific drivers:
  - `ocp8178-bl` - Backlight control
  - `panel-clockwork-cwu50` - Display panel
  - `simple-amplifier-switch` - Audio switching

**Why This Approach:**

The uConsole requires specific kernel patches that aren't available in mainline Linux. The `nixos-uconsole` project identified a working combination of:
1. A specific Raspberry Pi kernel version (6.1.63 from late 2023)
2. Hardware driver patches from the PotatoMania uConsole project
3. Kernel configuration tailored for the uConsole's custom hardware

This module implements the same proven approach but in a clean, modular fashion.

**Sources:**
- Kernel version and source from [nixos-uconsole 6.1-potatomania](https://github.com/voidcontext/nixos-uconsole/tree/main/kernels/6.1-potatomania)
- Hardware patches from [PotatoMania's uConsole CM3 project](https://github.com/PotatoMania/uconsole-cm3)
- Kernel configuration options from [jhewitt.net/uconsole](https://jhewitt.net/uconsole)
- Performance tuning based on embedded Linux best practices

### `boot.nix` - Boot and SD Card Configuration

Handles the boot process and SD card image generation for the uConsole.

**Key Features:**

- **Boot Loader**: Uses `generic-extlinux-compatible` for ARM devices
- **Filesystem Layout**:
  - Root partition labeled `NIXOS_SD` with ext4 and `noatime` for SSD longevity
  - Firmware partition labeled `FIRMWARE` with FAT32 for boot files
  - 1GB swap file for memory-constrained environment

- **SD Image Configuration**:
  - Custom image naming with NixOS version and architecture
  - 128MB firmware partition size
  - Custom `config.txt` with uConsole-specific settings (commented out for basic boot)

**Config.txt Settings** (currently commented for basic boot testing):
- `arm_64bit=1` - Enable 64-bit mode
- `enable_uart=1` - Enable UART for debugging
- `hdmi_force_hotplug=1` - Force HDMI detection for external displays
- `gpu_mem=128` - Allocate 128MB to GPU
- uConsole-specific settings for display, audio, and GPIO configuration

**Sources:**
- SD image configuration from NixOS ARM64 examples
- Config.txt settings adapted from [ClockworkPi uConsole documentation](https://github.com/clockworkpi/uConsole) and [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)

### `system.nix` - Basic System Configuration

Contains fundamental system settings, networking, users, and packages.

**Key Configuration:**

- **Networking**: Uses NetworkManager for WiFi and connection management
- **System Packages**: Essential tools for embedded development and debugging:
  - Hardware tools: `i2c-tools`, `libraspberrypi`, `raspberrypi-eeprom`
  - Debugging: `htop`, `lsof`, `lshw`, `usbutils`, `pciutils`
  - Display tools: `fbset` for framebuffer management
  - Development: `vim`, `git`, `curl`, `wget`

- **Console Configuration**: 
  - `kmscon` with hardware rendering for better terminal experience
  - Terminus font for readability on small screen

- **User Setup**:
  - Default user `uconsole` with access to hardware groups (`i2c`, `gpio`, `spi`)
  - Temporary password setup (should be changed in production)

- **Build Optimization**:
  - Raspberry Pi cachix for faster ARM builds
  - Binary cache to avoid rebuilding ARM packages

**Sources:**
- Package selection based on common embedded Linux development needs
- User group assignments from [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)
- Cachix configuration for Raspberry Pi from [nixos-hardware](https://github.com/NixOS/nixos-hardware)

### `hardware.nix` - uConsole Hardware Configuration

Configures Raspberry Pi specific hardware features and uConsole peripherals.

**Key Features:**

- **Raspberry Pi Hardware**:
  - `fkms-3d.enable` - Fake KMS for 3D acceleration
  - `dwc2` in host mode for USB functionality
  - Device tree overlay merging enabled

- **Peripheral Support**:
  - I2C enabled for PMU, sensors, and other components
  - Bluetooth with power-on-boot for connectivity
  - Custom udev rules for GPIO, I2C, and SPI access

- **Power Management**:
  - `upower` for battery monitoring with uConsole-appropriate thresholds
  - `tlp` for CPU frequency scaling and battery optimization
  - Conservative charging thresholds (20%-80%) for battery longevity

- **Future Features** (commented out):
  - X11 configuration with fbdev/modesetting drivers
  - i3 window manager setup
  - Audio support with PipeWire

**Sources:**
- Hardware configuration from [nixos-hardware Raspberry Pi modules](https://github.com/NixOS/nixos-hardware/tree/master/raspberry-pi)
- Power management settings adapted from laptop configurations and [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)
- udev rules for hardware access from embedded Linux practices

### Device Tree Overlays

The device tree overlays configure the uConsole's custom hardware that differs from a standard Raspberry Pi.

#### `dt-misc.nix` - Miscellaneous Hardware

Configures I2C, SPI, UART, and GPIO for various uConsole components.

**Configuration Details:**
- **I2C1**: Configured on pins 44/45 for ADC (TI ADC101C at address 0x54)
- **SPI4**: Configured on pins 6/7 with CS on pin 4 for peripheral communication
- **UART1**: Configured on pins 14/15 for additional serial communication
- **GPIO Pin Functions**: Sets up pin multiplexing for the above interfaces

**Sources:**
- Device tree structure from [clockworkpi-uconsole-overlays](https://github.com/voidcontext/nixos-uconsole/blob/main/kernels/clockworkpi-uconsole-overlays.nix)
- Pin assignments from ClockworkPi uConsole hardware documentation

#### `dt-display.nix` - Display Panel

Configures the uConsole's 5-inch 1280x720 DSI display.

**Configuration Details:**
- **DSI1 Interface**: Configures the Display Serial Interface
- **Panel Definition**: Clockwork CWU50 panel with:
  - Reset GPIO on pin 8
  - 90-degree rotation for proper orientation
  - OCP8178 backlight controller on GPIO 9
  - Default brightness level 5

**Sources:**
- Display configuration from [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)
- Panel specifications from ClockworkPi hardware documentation
- Backlight controller settings from uConsole schematics

#### `dt-pmu.nix` - Power Management Unit

Configures the AXP223 Power Management IC for battery and power regulation.

**Configuration Details:**
- **AXP223 PMIC**: Located at I2C address 0x34 with interrupt on GPIO 2
- **Voltage Regulators**:
  - `aldo1` (3.3V) - Audio power supply
  - `aldo2` (3.3V) - Display power supply
  - `dldo2/3/4` (3.3V) - Additional 3.3V rails
- **Battery Management**: Integrated battery monitoring and charging control
- **AC Power Supply**: USB-C power input detection

**Sources:**
- PMU configuration from [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)
- AXP223 register settings from X-Powers AXP223 datasheet
- Power supply naming from uConsole schematics

#### `dt-overlays.nix` - Additional Overlays

Includes standard Raspberry Pi overlays needed for graphics and audio.

**Overlays:**
- **vc4-kms-v3d-pi4**: GPU driver with 384MB CMA allocation
- **audremap**: Audio routing to pins 12/13 for headphone output

**Sources:**
- Standard overlays from Raspberry Pi kernel tree
- CMA allocation tuned for uConsole's display requirements

### `hardware-configuration.nix` - Hardware Detection

Simplified to contain only filesystem and swap configuration after modularization.

**Contents:**
- Root filesystem on NIXOS_SD label with ext4 and noatime
- Firmware partition configuration for boot files
- 1GB swap file definition

**Sources:**
- Generated by `nixos-generate-config` and manually tuned for SD card optimization

## Usage

### Building the Configuration

```bash
# Build the SD image with custom kernel
nix build .#nixosConfigurations.uconsole.config.system.build.sdImage

# Build just the system
nix build .#nixosConfigurations.uconsole.config.system.build.toplevel

# Build only the custom kernel (for testing)
nix build .#nixosConfigurations.uconsole.config.boot.kernelPackages.kernel
```

**Important Notes:**

- **Build Time**: The custom kernel with patches will take significantly longer to build than standard kernels
- **Cross Compilation**: Consider using a powerful x86_64 machine for kernel compilation
- **Binary Cache**: The custom kernel likely won't be available in binary caches and must be built from source
- **Patches**: Ensure all patch files are present in the `patches/` directory before building

### Customization

Each module can be independently modified:

- **Disable modules**: Comment out imports in `configuration.nix`
- **Modify kernel**: Edit kernel parameters in `kernel.nix`
- **Change display settings**: Modify device tree in `dt-display.nix`
- **Adjust power management**: Update settings in `hardware.nix`

### Development Workflow

1. **Basic Boot Testing**: Current configuration prioritizes successful boot
2. **Hardware Enablement**: Uncomment device tree overlays as needed
3. **Display Configuration**: Enable X11 settings in `hardware.nix`
4. **Audio Setup**: Uncomment audio configuration when ready

## Hardware Support Status

- ✅ **Custom Kernel**: 6.1.63-potatomania with uConsole patches applied
- ✅ **Basic Boot**: Kernel loads and system starts with hardware drivers
- ✅ **Serial Console**: UART debugging available
- ✅ **Networking**: WiFi via NetworkManager
- ✅ **SSH**: Remote access enabled
- ✅ **Display Drivers**: CWU50 panel driver compiled and available
- ✅ **Backlight Control**: OCP8178 driver compiled and available
- ✅ **Power Management**: AXP20x drivers with uConsole customizations
- ✅ **Battery Monitoring**: Enhanced battery calibration support
- ✅ **Audio Drivers**: Simple amplifier switch driver available
- 🚧 **Display Output**: Hardware configured, testing display activation needed
- 🚧 **Backlight**: Driver available, testing brightness control needed
- 🚧 **Battery**: PMU configured, verifying charge reporting needed
- ⏳ **Audio Output**: Hardware drivers ready, audio stack configuration pending
- ⏳ **Keyboard**: Input device configuration pending
- ⏳ **Trackball**: Input device configuration pending

## Troubleshooting

### Common Issues

1. **Boot Fails**: Check kernel parameters in `kernel.nix`
2. **No Display**: Verify device tree overlays in `dt-*.nix` files
3. **Hardware Not Detected**: Check udev rules in `hardware.nix`
4. **Performance Issues**: Adjust CMA allocation and swappiness settings

### Debug Resources

- **Serial Console**: Connect to GPIO 14/15 at 115200 baud
- **SSH Access**: Default IP via NetworkManager
- **Logs**: `journalctl -f` for real-time system logs
- **Hardware Info**: `lshw`, `lsusb`, `i2cdetect` for hardware detection

## References

- [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole) - Primary configuration source
- [ClockworkPi uConsole](https://github.com/clockworkpi/uConsole) - Official hardware documentation and schematics
- [NixOS Hardware](https://github.com/NixOS/nixos-hardware) - Raspberry Pi configurations
- [Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/) - Hardware reference
- [uConsole Wiki](https://github.com/clockworkpi/uConsole/wiki) - Community documentation and guides

## Contributing

When modifying this configuration:

1. Test changes incrementally
2. Document the source of any new settings
3. Update this README with significant changes
4. Consider backward compatibility for existing installations

## License

This configuration is provided as-is for educational and development purposes. Refer to individual component licenses for specific terms.
