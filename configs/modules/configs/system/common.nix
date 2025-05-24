{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    # Login and greeter
    ./services/login/greeter.nix
    ./services/login/displayManager.nix

    # Security and secrets
    ./services/security/gnupg.nix
    ./services/security/gnome-keyring.nix
    #./services/security/sops.nix

    # Networking
    ./services/networks/network-manager.nix
    ./services/networks/bluetooth.nix
    ./services/networks/kdeconnect.nix
    ./services/networks/localsend.nix

    # Audio
    ./services/audio/pipewire.nix

    # UI
    ./services/graphics/wayland.nix
    ./services/graphics/hyprland.nix

    # Support for hardware
    ./services/hardware/yubikey.nix
    ./services/hardware/power.nix
    ./services/hardware/i2c.nix
    ./services/hardware/ratbagd.nix
    ./services/hardware/rtl-sdr.nix
    ./services/hardware/printing.nix
    ./services/hardware/ddccontrol.nix
    ./services/storage/udisks2.nix

    # Virtualization and Docker
    ./services/virtualization/virtualization.nix
    ./services/virtualization/docker.nix

    # Gaming
    ./services/gaming/steam.nix

    # Appimage Support
    ./services/appimage.nix

    # Virtual FS (used to cache album art)
    ./services/gvfs.nix

  ];

  # Some common settings that will carry across all systems
  # TODO: break these out into discrete modules

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # required for sway according to docs
  security.polkit.enable = true;

  # Required for swaylock to work
  security.pam.services.swaylock = { text = "	auth include login\n"; };

  # Give seahorse access to GNOME Keyring
  programs.seahorse.enable = true;

  # enable fish systemwide
  programs.fish.enable = true;

  # list of programs I want to execute WITHOUT passwd (ie from waybar)
  security.sudo = {
    enable = true;
    # HACK: I wanted to use extrarules but it just refuses to work...
    extraConfig = ''
      %wheel	ALL=(root)	NOPASSWD: /run/current-system/sw/bin/light
    '';
  };

  # TEST: disable docs to speed builds
  documentation.nixos.enable = false;
}
