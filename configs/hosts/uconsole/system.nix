{ config, lib, pkgs, ... }:

{
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
    tmux
    # Display and framebuffer tools
    fbset
    # Hardware debugging
    lshw
    # Hardware tools
    rpi-imager
    gptfdisk
  ];

  # Enable console and framebuffer for visual output
  console = {
    enable = true;
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable basic framebuffer console
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = ''
      font-size=12
      xkb-layout=us
    '';
  };

  # Enable SSH for remote access during setup
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes"; # Change to "no" after initial setup
      PasswordAuthentication = true; # Consider disabling after adding keys
    };
  };

  # Ensure getty services are enabled for TTY access
  systemd.services."getty@tty1".enable = true;
  systemd.services."getty@tty2".enable = true;

  # User configuration
  users.users.uconsole = {
    isNormalUser = true;
    initialPassword = "uconsole"; # CHANGE THIS!
    extraGroups =
      [ "wheel" "networkmanager" "video" "audio" "i2c" "gpio" "spi" ];
  };

  # Enable sudo
  security.sudo.wheelNeedsPassword = false; # Set to true for production

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

  # System state version (don't change this after installation)
  system.stateVersion = "25.05";
}
