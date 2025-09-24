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
    #./hardware-configuration.nix

    # my public keys
    ../../../modules/keys/ssh.nix

    # Common system configs
    ../../../modules/configs/system/common.nix

    # Secrets
    ./sops.nix

    # System Wide Theming
    ./stylix.nix

    # SSH
    ../../../modules/configs/system/services/networks/ssh.nix

    ############
    # PACKAGES #
    ############

    # Flatpak
    ../../../modules/packages/system/flatpak.nix

    # Audio
    ../../../modules/packages/system/audio.nix

    # Video
    ../../../modules/packages/system/video.nix

    # Development
    ../../../modules/packages/system/development.nix

    # Networking
    ../../../modules/packages/system/networking.nix

    # Graphics
    ../../../modules/packages/system/ui.nix

    # System
    ../../../modules/packages/system/system.nix

  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "alpha"; # Define your hostname.

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

  # TODO: extract this out so I don't have to update groups on every machine
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    initialPassword = "pw123";
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
    openssh = {
      authorizedKeys.keys = [ config.local.ssh.keys.gideon_ssh_sk ];
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?

}
