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

    ../../secrets/system_secrets.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # General System Settings
    ./system/system/system.nix

    # Login manager/greeter
    ../../modules/configs/system/services/login/greeter.nix
    #./system/services/greeter.nix

    # GNOME Keyring
    ../../modules/configs/system/services/gnome-keyring.nix
    #./system/services/gnome-keyring.nix

    # Virtualization 
    ../../modules/configs/system/services/virtualization.nix
    #./system/services/virtualization.nix

    # System level theming
    ./system/graphics/stylix.nix

    # Networking and Bluetooth
    ../../modules/configs/system/services/networks/network-manager.nix
    ../../modules/configs/system/services/networks/bluetooth.nix
    #./system/services/networks/networking.nix
    # ./system/services/networks/bluetooth.nix
    # ./system/services/networks/ssh.nix
    # ./system/services/networks/wireguard.nix
    # ./system/services/networks/firewall.nix
    ../../modules/configs/system/services/kdeconnect.nix

    # Local Send
    ../../modules/configs/system/services/localsend.nix

    # Docker
    ../../modules/configs/system/services/docker.nix
    #./system/services/docker.nix

    # Printer support
    ../../modules/configs/system/services/printing.nix
    #./system/services/printing.nix

    # Virtual FS (used to cache album art)
    ../../modules/configs/system/services/gvfs.nix
    #./system/services/gvfs.nix

    # Appimage support
    ../../modules/configs/system/services/appimage.nix

    # UI
    ../../modules/configs/system/services/graphics/wayland.nix
    ../../modules/configs/system/services/graphics/hyprland.nix
    # ./system/graphics/hyprland.nix
    # ./system/graphics/wayland.nix

    # Audio
    ../../modules/configs/system/services/audio/pipewire.nix
    #./system/services/audio/pipewire.nix

    # Local plantuml server
    ../../modules/configs/system/services/plantuml.nix
    # ./system/services/plantuml.nix

    # Config firewall, etc. for steam
    ../../modules/configs/system/services/steam.nix
    # ./system/services/steam.nix

    # service for configuring gaming mice
    ../../modules/configs/system/services/ratbagd.nix
    # ./system/services/ratbagd.nix

    # adding extensions for nautilus
    ../../modules/configs/system/nautilus.nix

    # service for configuring external display brightness and other settings
    ../../modules/configs/system/services/ddccontrol.nix
    # Needed for above to work, but also needed for any i2c dev stuff
    ../../modules/configs/system/services/i2c.nix

    # Needed for above to work, but also needed for any i2c dev stuff
    ../../modules/configs/system/services/rtl-sdr.nix

    # AI stuff
    ../../modules/configs/system/services/ai/sillytavern.nix

    ##TESTING RESTIC
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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hades"; # Define your hostname.

  # Enable Fish shell
  programs.fish.enable = true;

  # Give seahorse access to GNOME Keyring
  programs.seahorse.enable = true;

  # required for sway according to docs
  security.polkit.enable = true;

  # Required for swaylock to work
  security.pam.services.swaylock = { text = "	auth include login\n"; };

  #hardware.opengl.enable = true;

  # enable CKB Next for my corsair keyboard
  hardware.ckb-next.enable = true;

  services.weechat.enable = false;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # list of programs I want to execute WITHOUT passwd (ie from waybar)
  security.sudo = {
    enable = true;
    # HACK: I wanted to use extrarules but it just refuses to work...
    extraConfig = ''
      %wheel	ALL=(root)	NOPASSWD: /run/current-system/sw/bin/light
    '';
  };

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
    ];
    packages = with pkgs; [ firefox neovim tree ];
  };

  # BUG: google oath doesn't reconnect to gnome-control-center
  services.gnome.gnome-online-accounts.enable = true;
  services.accounts-daemon.enable = true;
  services.gnome.evolution-data-server.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

}
