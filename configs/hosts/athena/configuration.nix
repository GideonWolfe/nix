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

    # Enable restic for backups
    ../../modules/configs/system/services/restic.nix

    # General System Settings
    ./system/system/system.nix

    # Secrets
    #./secrets/secret_defs.nix
    ../../secrets/system_secrets.nix

    # SOPS
    ../../modules/configs/system/services/sops.nix

    # Yubikey support
    ../../modules/configs/system/services/yubikey.nix

    # Enable GPG
    ../../modules/configs/system/services/gnupg.nix

    # Enable snapraid for drives
    ./system/system/snapraid.nix

    # Fan control #BUG:
    #./system/system/fancontrol.nix

    # Login manager/greeter
    #./system/services/greeter.nix
    ../../modules/configs/system/services/login/greeter.nix

    # GNOME Keyring
    #./system/services/gnome-keyring.nix
    ../../modules/configs/system/services/gnome-keyring.nix

    #smartd hdd health
    ./system/services/smartd.nix
    ./system/services/scrutiny.nix

    # System level theming
    ./system/graphics/stylix.nix

    # Networking and Bluetooth
    #./system/services/networks/networking.nix
    ../../modules/configs/system/services/networks/network-manager.nix
    #./system/services/networks/bluetooth.nix
    ../../modules/configs/system/services/networks/bluetooth.nix

    ./system/services/networks/ssh.nix
    ./system/services/networks/firewall.nix

    # automatically mount external disks
    #./system/services/udisks2.nix
    ../../modules/configs/system/services/storage/udisks2.nix

    # Docker
    #./system/services/docker.nix
    ../../modules/configs/system/services/docker.nix

    # Printer support
    #./system/services/printing.nix
    ../../modules/configs/system/services/printing.nix

    # Virtual FS (used to cache album art)
    #./system/services/gvfs.nix

    # UI
    #./system/graphics/hyprland.nix
    ../../modules/configs/system/services/graphics/hyprland.nix
    #./system/graphics/wayland.nix
    ../../modules/configs/system/services/graphics/wayland.nix

    # Audio
    #./system/services/audio/pipewire.nix
    ../../modules/configs/system/services/audio/pipewire.nix

    ############
    # PACKAGES #
    ############

    # Audio
    #./system/packages/audio.nix
    ../../modules/packages/system/audio.nix

    # Video
    #./system/packages/video.nix
    ../../modules/packages/system/video.nix

    # Development
    #./system/packages/development.nix

    # Networking
    #./system/packages/networking.nix
    ../../modules/packages/system/networking.nix

    # Graphics
    #./system/packages/ui.nix
    ../../modules/packages/system/ui.nix

    # System
    #./system/packages/system.nix
    ../../modules/packages/system/system.nix

    # Services
    ./server/services/productivity/monica/monica.nix
    ./server/services/productivity/actualbudget/actualbudget.nix
    ./server/services/productivity/mealie/mealie.nix
    ./server/services/productivity/freshrss/freshrss.nix
    ./server/services/productivity/hoarder/hoarder.nix
    ./server/services/productivity/paperless/paperless.nix
    #./server/services/productivity/saltrim/saltrim.nix
    ./server/services/media/nzbget.nix
    ./server/services/media/sonarr.nix
    ./server/services/media/radarr.nix
    ./server/services/media/lidarr.nix
    ./server/services/media/bazarr.nix
    ./server/services/media/tdarr.nix
    ./server/services/media/recyclarr.nix
    ./server/services/media/prowlarr.nix
    ./server/services/media/jellyfin.nix
    ./server/services/media/jellyseerr.nix
    ./server/services/media/navidrome.nix
    ./server/services/media/calibre-web-automated.nix
    ./server/services/media/calibre-web-automated-downloader.nix
    ./server/services/admin/homarr.nix
    ./server/services/media/slskd.nix
    ./server/services/media/romm.nix

    ./server/services/productivity/vaultwarden/vaultwarden.nix

    ./server/services/networking/wireguard.nix
    #./server/services/networking/traefik/traefik.nix
    ./server/services/networking/traefik/nix_traefik.nix
    ./server/services/networking/crowdsec/crowdsec.nix

    #./server/services/productivity/nextcloud/nextcloud-aio-mastercontainer.nix
    ./server/services/productivity/nextcloud/nextcloud.nix
    ./server/services/productivity/triliumnext/triliumnext.nix

    # Wiki backups
    ./server/services/productivity/kiwix/kiwix.nix

    # Obsidian Syncing
    #./server/services/productivity/obsidian-livesync/obsidian-livesync.nix
  ];

  #stylix.image = ./system/graphics/zT7uCe2.png;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "athena"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  #time.timeZone = "America/New_York";

  programs.fish.enable = true;

  # required for sway according to docs
  security.polkit.enable = true;

  # Required for swaylock to work
  #security.pam.services.swaylock = { text = "	auth include login\n"; };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # list of programs I want to execute WITHOUT passwd (ie from waybar)
  security.sudo = {
    enable = true;
    extraConfig = ''
      %wheel	ALL=(root)	NOPASSWD: /run/current-system/sw/bin/light
    '';
    # extraRules = [{
    #
    #   groups = [ "wheel" ];
    #   commands = [{
    #     command = "/run/current-system/sw/bin/iotop";
    #     options = [ "NOPASSWD" ];
    #   }];
    # }];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.overseer = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker" # Let the user run docker commands
      "dialout" # let programs run by the user (like chirp) access USB ports
    ];
    packages = with pkgs; [ firefox tree git ];
  };

  #TODO: make these fail gracefully when network already exists
  system.activationScripts.makeMonicaNetwork = ''
    ${pkgs.docker}/bin/docker network create net_monica || true
  '';
  system.activationScripts.makeMediaNetwork = ''
    ${pkgs.docker}/bin/docker network create net_media || true
  '';
  system.activationScripts.makeTraefikProxyNetwork = ''
    ${pkgs.docker}/bin/docker network create traefik_proxy || true
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.stateVersion = "24.05";

}
