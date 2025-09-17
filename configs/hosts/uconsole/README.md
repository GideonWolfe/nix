# uConsole NixOS Configuration

This directory contains a modular NixOS configuration for the ClockworkPi uConsole, a handheld Linux computer based on the Raspberry Pi CM4.

## Overview

The configuration is split into focused modules to separate concerns and improve maintainability. Each module handles a specific aspect of the uConsole hardware or system configuration.

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

Contains all kernel-related configuration for the uConsole's Raspberry Pi CM4.

**Key Settings:**

- **Kernel Package**: Uses `linuxPackages_rpi4` for optimal Raspberry Pi 4/CM4 support
- **Kernel Modules**: 
  - `i2c-dev`, `i2c-bcm2835` - I2C support for PMU and sensors
  - `spi-bcm2835` - SPI support for various peripherals
  - `vc4`, `v3d` - GPU and 3D acceleration support
  - `bcm2835_fb`, `fb_sys_fops` - Framebuffer support for display

- **Kernel Parameters**:
  - `console=tty1` - Primary console on main display
  - `console=serial0,115200` - Serial console for debugging
  - `cma=128M` - Contiguous Memory Allocator for GPU (reduced for testing)
  - `loglevel=7`, `initcall_debug`, `debug` - Verbose logging for troubleshooting

- **System Control (sysctl)**:
  - Low swappiness (10) - Prefer RAM over swap for better performance
  - Reduced dirty ratios (5%/10%) - More frequent writes to storage

**Sources:**
- Kernel parameters derived from [nixos-uconsole](https://github.com/voidcontext/nixos-uconsole)
- Raspberry Pi kernel modules from standard RPi NixOS configurations
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
# Build the SD image
nix build .#nixosConfigurations.uconsole.config.system.build.sdImage

# Build just the system
nix build .#nixosConfigurations.uconsole.config.system.build.toplevel
```

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

- ✅ **Basic Boot**: Kernel loads and system starts
- ✅ **Serial Console**: UART debugging available
- ✅ **Networking**: WiFi via NetworkManager
- ✅ **SSH**: Remote access enabled
- 🚧 **Display**: Device tree configured, testing needed
- 🚧 **Battery**: PMU configured, monitoring available
- ⏳ **Audio**: Hardware configured, software setup pending
- ⏳ **Keyboard**: Hardware should work, key mapping may need adjustment
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
