# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ###########
    # CONFIGS #
    ###########

    ../../modules/icons.nix

    #../../secrets/system_secrets.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # General System Settings
    ./system/system/system.nix

    # Login manager/greeter
    ../../modules/configs/system/services/login/greeter.nix
    ../../modules/configs/system/services/login/displayManager.nix

    # GNOME Keyring
    ../../modules/configs/system/services/gnome-keyring.nix

    # GPG
    ../../modules/configs/system/services/gnupg.nix
    # Yubikey
    ../../modules/configs/system/services/yubikey.nix

    # Virtualization 
    ../../modules/configs/system/services/virtualization.nix

    # System level theming
    ./system/graphics/stylix.nix

    # Networking and Bluetooth
    ./system/services/networks/ssh.nix
    ./system/services/networks/wireguard.nix
    ../../modules/configs/system/services/networks/network-manager.nix
    ../../modules/configs/system/services/networks/bluetooth.nix
    ../../modules/configs/system/services/kdeconnect.nix

    # Power management services
    ../../modules/configs/system/services/power.nix

    # Docker
    ../../modules/configs/system/services/docker.nix

    # Printer support
    ../../modules/configs/system/services/printing.nix

    # Virtual FS (used to cache album art)
    ../../modules/configs/system/services/gvfs.nix

    # Appimage support
    ../../modules/configs/system/services/appimage.nix

    # UI
    ../../modules/configs/system/services/graphics/hyprland.nix
    ../../modules/configs/system/services/graphics/wayland.nix

    # Audio
    ../../modules/configs/system/services/audio/pipewire.nix

    # Local plantuml server
    ../../modules/configs/system/services/plantuml.nix

    # Config firewall, etc. for steam
    ../../modules/configs/system/services/steam.nix

    # service for configuring gaming mice
    ../../modules/configs/system/services/ratbagd.nix

    # service for RTL-SDR
    ../../modules/configs/system/services/rtl-sdr.nix

    # TESTING
    ../../modules/configs/system/services/restic.nix


    ############
    # PACKAGES #
    ############

    # Flatpak
    #./system/packages/flatpak.nix
    ../../modules/packages/system/flatpak.nix

    # Audio
    #./system/packages/audio.nix
    ../../modules/packages/system/audio.nix

    # Video
    #./system/packages/video.nix
    ../../modules/packages/system/video.nix

    # Development
    #./system/packages/development.nix
    ../../modules/packages/system/development.nix

    # Networking
    #./system/packages/networking.nix
    ../../modules/packages/system/networking.nix

    # Graphics
    #./system/packages/ui.nix
    ../../modules/packages/system/ui.nix

    # System
    #./system/packages/system.nix
    ../../modules/packages/system/system.nix

  ];

  #stylix.image = ./system/graphics/zT7uCe2.png;

  # TEST: disable docs to speed builds
  documentation.nixos.enable = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "poseidon"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  #time.timeZone = "America/New_York";

  programs.fish.enable = true;

  # Give seahorse access to GNOME Keyring
  programs.seahorse.enable = true;

  # required for sway according to docs
  security.polkit.enable = true;

  # Required for swaylock to work
  security.pam.services.swaylock = { text = "	auth include login\n"; };

  #hardware.opengl.enable = true;

  services.weechat.enable = false;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # TODO required for Hyprland to run, but causes lag. even in Sway when it was snappy before
  #environment.sessionVariables = rec {
  #  WLR_RENDERER_ALLOW_SOFTWARE = "1";
  #};

  # list of programs I want to execute WITHOUT passwd (ie from waybar)
  security.sudo = {
    enable = true;
    # HACK: I wanted to use extrarules but it just refuses to work...
    extraConfig = ''
      %wheel	ALL=(root)	NOPASSWD: /run/current-system/sw/bin/light
    '';
    # extraRules = [{
    #   commands = [
    #     {
    #       command = "/run/current-system/sw/bin/iotop";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "/run/current-system/sw/bin/light";
    #       #command = "${pkgs.light}/bin/light";
    #       options = [ "NOPASSWD" ];
    #     }
    #   ];
    #   groups = [ "wheel" ];
    # }];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker" # Let the user run docker commands
      "dialout" # let programs run by the user (like chirp) access USB ports
      "input" # let programs run by the user (like chirp) access touchpad input (for fusuma gestures)
      "plugdev" # for RTL-SDR
      "storage" # for udiskie
    ];
    packages = with pkgs; [ firefox vim tree ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  programs.hyprland.enable = true;

}
