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

    # Networking
    ./system/ssh.nix
    ./system/wireguard.nix

    # Local plantuml server
    ../../modules/configs/system/services/plantuml.nix

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

  networking.hostName = "poseidon"; # Define your hostname.

  #time.timeZone = "America/New_York";
  services.automatic-timezoned.enable = true;

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

  system.stateVersion = "23.11";

}
