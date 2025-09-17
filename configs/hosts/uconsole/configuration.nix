{ config, lib, pkgs, modulesPath, inputs, ... }:
let

  overlay = final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // { allowMissing = true; });
  };

in {
  imports = [
    # Import the SD image generator
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"

    # Hardware configuration for Raspberry Pi
    "${modulesPath}/profiles/base.nix"

    # This is automatically included from flake.nix now
    # inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  # HACK: fix the bug with missing firmware
  nixpkgs.overlays = [ overlay ];

  # Enable Raspberry Pi cachix for faster ARM builds
  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nixos-raspberrypi.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

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
    # Debugging tools
    file
    lsof
    tree
    wget
    curl
    screen
    # Hardware tools
    rpi-imager
    gptfdisk
  ];

  # Boot configuration for Raspberry Pi CM4
  boot = {
    loader = {
      # Use the extlinux boot loader for ARM
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
      timeout = 5;
    };

    # Kernel modules needed for uConsole hardware
    kernelModules = [ "i2c-dev" "spi-bcm2835" "i2c-bcm2835" "bcm2835_dma" ];

    # Use the latest Raspberry Pi kernel
    kernelPackages = pkgs.linuxPackages_rpi4;

    # Kernel parameters for CM4 support with debugging
    kernelParams = [
      "console=tty1"  # Only use the main display console
      "8250.nr_uarts=1"
      "cma=128M"
      "elevator=deadline"
      "fsck.repair=yes"
      "net.ifnames=0"
      # Debug options (these will show on the main display)
      "loglevel=7"
      "systemd.log_level=debug"
      "systemd.log_target=console"
    ];

    # Enable required kernel features
    kernel.sysctl = { 
      "vm.swappiness" = 10;
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
    };

    # Enable initrd for better hardware support
    initrd = {
      availableKernelModules = [ 
        "usbhid" "usb_storage" "vc4" "pcie_brcmstb" "reset-raspberrypi"
      ];
      kernelModules = [ ];
    };

    # Enable early debugging and logging
    plymouth.enable = false; # Disable splash screen for better debugging
  };

  # Hardware-specific configuration
  hardware = {
    enableRedistributableFirmware = true;

    # Enable Raspberry Pi specific hardware
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      fkms-3d.enable = true;
      #audio.enable = true;
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
    populateRootCommands = ''
      mkdir -p ./files/boot
    '';
  };

  # Display configuration for uConsole screen (disabled for initial boot testing)
  # services.xserver = {
  #   enable = true;

  #   # Configure for the uConsole's display
  #   videoDrivers = [ "fbdev" "modesetting" ];

  #   # Display manager (you can change this to your preference)
  #   displayManager.lightdm.enable = true;
  #   displayManager.lightdm.greeters.gtk.enable = true;

  #   # Window manager (adjust to your preference)
  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [ dmenu i3status i3lock ];
  #   };

  #   # Input configuration for uConsole keyboard/trackball
  #   libinput = {
  #     enable = true;
  #     touchpad = {
  #       tapping = true;
  #       scrollMethod = "twofinger";
  #     };
  #   };

  #   # Screen configuration for 5" 1280x720 display
  #   xrandrHeads = [{
  #     output = "DSI-1";
  #     primary = true;
  #     monitorConfig = ''
  #       Option "PreferredMode" "1280x720"
  #     '';
  #   }];
  # };

  # Audio configuration (disabled for initial testing)
  # sound.enable = true;
  # hardware.pipewire.enable = true;

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
  system.stateVersion = "25.05";
}
