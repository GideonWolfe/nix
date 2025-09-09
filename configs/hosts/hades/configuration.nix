# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ###########
    # CONFIGS #
    ###########

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Common system configs
    ../../modules/configs/system/common.nix

    # Secrets
    ./system/sops.nix

    # System Wide Theming
    ./system/stylix.nix

    # SSH
    ../../modules/configs/system/services/networks/ssh.nix

    # Local plantuml server
    ../../modules/configs/system/services/plantuml.nix

    # AI stuff
    ../../modules/configs/system/services/ai/sillytavern.nix
    #TEST: localAI
    ../../modules/configs/system/services/ai/localai.nix

    # Testing Hamclock
    ../../modules/configs/system/services/hamclock.nix

    # Testing NetBox
    ../../modules/configs/system/services/networks/netbox/netbox.nix

    # Testing Prometheus Agent
    #./system/prometheus.nix
    ./system/alloy.nix

    ############
    # PACKAGES #
    ############

    # Flatpak
    ../../modules/packages/system/flatpak.nix

    # Audio
    ../../modules/packages/system/audio.nix

    # Video
    ../../modules/packages/system/video.nix

    # Development
    ../../modules/packages/system/development.nix

    # Networking
    ../../modules/packages/system/networking.nix

    # Graphics
    ../../modules/packages/system/ui.nix

    # System
    ../../modules/packages/system/system.nix

  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hades"; # Define your hostname.

  time.timeZone = "America/New_York";

  # put in its own file
  boot.plymouth = {
    # Enable plymouth on the system
    enable = true;
    # Pass in the package of themes we also downloaded
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
    # Choose the theme
    # default is "stylix" but idk how to change it from stylix config
    # https://github.com/adi1090x/plymouth-themes
    theme = "motion";
  };

  # enable CKB Next for my corsair keyboard
  hardware.ckb-next.enable = true;

  # TODO: extract this out so I don't have to update groups on every machine
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
      "i2c" # allow the user to control i2c devices like external displays through ddc
      "plugdev" # needed for RTL-SDR
      "storage" # needed for udisks/udiskie
    ];
    packages = with pkgs; [ firefox tree ];
  };

  # BUG: google oath doesn't reconnect to gnome-control-center
  services.gnome.gnome-online-accounts.enable = true;
  services.accounts-daemon.enable = true;
  services.gnome.evolution-data-server.enable = true;


  system.stateVersion = "24.11"; # Did you read the comment?

}
