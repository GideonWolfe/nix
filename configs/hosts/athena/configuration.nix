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

    # Enable restic for backups
    ../../modules/configs/system/services/restic.nix

    # System Wide Theming
    ./system/stylix.nix

    # Secrets
    #./secrets/secret_defs.nix
    #../../secrets/system_secrets.nix

    # Enable snapraid for drives
    ./system/system/snapraid.nix

    # Fan control #BUG:
    #./system/system/fancontrol.nix

    # Enable backups of music library
    ./system/music_backup.nix
    
    # Enable backups of personal archive
    ./system/archive_backup.nix

    # Enable backups of notesarchive_backup.nix
    ./system/obsidian_backup.nix

    #smartd hdd health
    ./system/services/smartd.nix
    ./system/services/scrutiny.nix

    # Networking and Bluetooth
    ./system/services/networks/ssh.nix
    ./system/services/networks/firewall.nix

    ############
    # PACKAGES #
    ############

    # Audio
    ../../modules/packages/system/audio.nix

    # Video
    ../../modules/packages/system/video.nix

    # Development
    #./system/packages/development.nix

    # Networking
    ../../modules/packages/system/networking.nix

    # Graphics
    ../../modules/packages/system/ui.nix

    # System
    ../../modules/packages/system/system.nix
    ./system/packages/system.nix # need to merge

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
    ./server/services/networking/traefik/nix_traefik.nix
    ./server/services/networking/crowdsec/crowdsec.nix

    ./server/services/productivity/nextcloud/nextcloud.nix
    ./server/services/productivity/triliumnext/triliumnext.nix

    # Wiki backups
    ./server/services/productivity/kiwix/kiwix.nix

  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "athena"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  boot.plymouth = {
    # Enable plymouth on the system
    enable = false;
    # Pass in the package of themes we also downloaded
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
    # Choose the theme
    # default is "stylix" but idk how to change it from stylix config
    # https://github.com/adi1090x/plymouth-themes
    theme = "motion";
  };

  #programs.fish.enable = true;

  # required for sway according to docs
  #security.polkit.enable = true;

  # Required for swaylock to work
  #security.pam.services.swaylock = { text = "	auth include login\n"; };

  # Enable Flakes
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #nixpkgs.config.allowUnfree = true;

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

  system.stateVersion = "24.05";

}
