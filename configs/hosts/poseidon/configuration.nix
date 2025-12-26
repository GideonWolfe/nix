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

    # Import the gideon system user configuration
    ../../v3modules/users/gideon/gideon.nix

    # Secrets
    #./system/sops.nix

    # System Wide Theming
    #./system/stylix.nix

    # Networking
    # ./system/ssh.nix
    # ./system/wireguard.nix

    # Local plantuml server
    #../../modules/configs/system/services/plantuml.nix

    #TEST: localAI
    ../../modules/configs/system/services/ai/localai.nix

    ############
    # PACKAGES #
    ############

    # Flatpak
    # enabled in system.nix
    #../../modules/packages/system/flatpak.nix

    # merged into home packages
    # Audio
    #../../modules/packages/system/audio.nix

    # merged into home packages
    # Video
    #../../modules/packages/system/video.nix

    # Development
    #../../modules/packages/system/development.nix

    # Networking
    ../../modules/packages/system/networking.nix

    # Graphics
    #../../modules/packages/system/ui.nix

    # System
    ../../modules/packages/system/system.nix

  ];

  # TEST to allow cross compilation for ARM
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    # ....
  ];

  # now covered in system.nix import
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "poseidon"; # Define your hostname.

  # covered in system.nix import now
  #time.timeZone = "America/New_York";
  #services.automatic-timezoned.enable = true;

  # covered in system.nix import now
  # boot.plymouth = {
  #   # Enable plymouth on the system
  #   enable = true;
  #   # Pass in the package of themes we also downloaded
  #   themePackages = [ pkgs.adi1090x-plymouth-themes ];
  #   # Choose the theme
  #   # default is "stylix" but idk how to change it from stylix config
  #   # https://github.com/adi1090x/plymouth-themes
  #   theme = "motion";
  # };

  # abstracted to gideon.nix
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.gideon = {
  #   home = "/home/gideon";
  #   isNormalUser = true;
  #   shell = pkgs.fish;
  #   extraGroups = [
  #     "wheel" # Enable ‘sudo’ for the user.
  #     "docker" # Let the user run docker commands
  #     "dialout" # let programs run by the user (like chirp) access USB ports
  #     "input" # let programs run by the user (like chirp) access touchpad input (for fusuma gestures)
  #     "plugdev" # for RTL-SDR
  #     "storage" # for udiskie
  #   ];
  #   packages = with pkgs; [ firefox vim tree ];
  # };

  system.stateVersion = "23.11";

}
