{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # Import the SD image generator
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"

    # Hardware configuration for Raspberry Pi
    "${modulesPath}/profiles/base.nix"
  ];

  # Basic system configuration
  networking.hostName = "uconsole";

  # Enable NetworkManager for easier network management
  networking.networkmanager.enable = true;

  # System packages specific to uConsole
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    neofetch
    usbutils
    pciutils
    i2c-tools
    libraspberrypi
    raspberrypi-eeprom
  ];

  # Boot configuration for Raspberry Pi CM4
  boot = {
    loader = {
      # Use the extlinux boot loader for ARM
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
    };

    # Kernel modules needed for uConsole hardware
    kernelModules = [ "i2c-dev" "spi-bcm2835" "i2c-bcm2835" ];

    # Use the latest Raspberry Pi kernel
    kernelPackages = pkgs.linuxPackages_rpi4;

    # Kernel parameters for better CM4 support
    kernelParams =
      [ "console=ttyS1,115200" "console=tty1" "8250.nr_uarts=1" "cma=128M" ];

    # Enable required kernel features
    kernel.sysctl = { "vm.swappiness" = 10; };
  };

  # Hardware-specific configuration
  hardware = {
    enableRedistributableFirmware = true;

    # Enable Raspberry Pi specific hardware
    raspberry-pi."4" = {
      enable = true;
      fkms-3d.enable = true;
      audio.enable = true;
    };

    # Enable I2C for various uConsole components
    i2c.enable = true;

    # Bluetooth support
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # SD card image configuration
  sdImage = {
    # Use a reasonable image size (8GB)
    imageName =
      "nixos-uconsole-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.img";
    compressImage = false; # Set to true if you want compressed images

    # Partition sizes
    firmwareSize = 128; # MiB for firmware partition

    # Include firmware files
    populateFirmwareCommands = ''
      ${config.system.build.installBootLoader} ${config.system.build.toplevel} -d ./firmware
    '';

    # Root partition configuration
    populateRootCommands = "";
  };

  # Display configuration for uConsole screen
  services.xserver = {
    enable = true;

    # Configure for the uConsole's display
    videoDrivers = [ "fbdev" "modesetting" ];

    # Display manager (you can change this to your preference)
    displayManager.lightdm.enable = true;
    displayManager.lightdm.greeters.gtk.enable = true;

    # Window manager (adjust to your preference)
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status i3lock ];
    };

    # Input configuration for uConsole keyboard/trackball
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        scrollMethod = "twofinger";
      };
    };

    # Screen configuration for 5" 1280x720 display
    xrandrHeads = [{
      output = "DSI-1";
      primary = true;
      monitorConfig = ''
        Option "PreferredMode" "1280x720"
      '';
    }];
  };

  # Audio configuration
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Power management for battery operation
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Enable SSH for remote access during setup
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes"; # Change to "no" after initial setup
      PasswordAuthentication = true; # Consider disabling after adding keys
    };
  };

  # User configuration
  users.users.uconsole = {
    isNormalUser = true;
    initialPassword = "uconsole"; # CHANGE THIS!
    extraGroups =
      [ "wheel" "networkmanager" "video" "audio" "i2c" "gpio" "spi" ];
  };

  # Enable sudo
  security.sudo.wheelNeedsPassword = false; # Set to true for production

  # System state version (don't change this after installation)
  system.stateVersion = "24.05";
}
