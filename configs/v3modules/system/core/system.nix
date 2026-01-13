{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

# This is configuration that pretty much every system will need

{
  imports = [
    # Global Variables
    ../../lib/world.nix

    # Always enable stylix
    # Default theme is catppuccin, but can be overriden per system
    ./stylix.nix

    # Global Home Manager options
    ./home-manager.nix

    # Provide the option to enable VPN
    ./wireguard.nix

    # Provide the option to enable Secrets
    ./sops.nix

    #######################################
    # Import options for our custom roles #
    #######################################
    # Provide the option to enable monitoring
    ../roles/monitoring/monitoring.nix
    # Provide the option to enable gaming
    ../roles/gaming/gaming.nix
    # Provide the option to enable music production
    ../roles/music_production/music_production.nix
    # Provide the option to enable desktop/hardware support.
    # Should be used if system isn't a VPS. Enabled by default
    ../roles/desktop/desktop.nix
    # Provide the option to enable proxmox-guest virtualization support
    ../roles/proxmox-guest/proxmox-guest.nix

  ];

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow packages not supported on system
  nixpkgs.config.allowUnsupportedSystem = true;

  # disable docs to speed builds
  documentation.nixos.enable = false;

  # Covered in gideon.nix now
  #nix.settings.trusted-users = [ "root" "gideon" ];

  # Basic systemd boot configuration
  boot = {
    # Use systemd-boot as the bootloader
    loader = {
      systemd-boot = {
        enable = true;
        # Allow editing boot entries
        editor = false;
        # Keep only the latest 10 generations in boot menu
        configurationLimit = 10;
      };

      # Enable EFI support
      efi.canTouchEfiVariables = true;
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 2736 ];
    openFirewall = true;
    settings = {
      # Only allow logins from me with my yubikey
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Enable the Yubikey Agent, which replaces ssh-agent
  # Handles forwarding SSH auth requests to the Yubikey
  services.yubikey-agent.enable = true;
  # Notifies user when Yubikey awaiting touch
  programs.yubikey-touch-detector.enable = true;
  # Enable smartcard detection
  services.pcscd.enable = true;

  # Enable GPG Agent
  programs.gnupg.agent.enable = true;
  # Enable hardware support for GPG smartcards
  hardware.gpgSmartcards.enable = true;

  # Enable D-Bus
  services.dbus.enable = true;

  # Enable Network Manager
  networking.networkmanager.enable = true;

  # Set Timezone Automatically
  services.automatic-timezoned.enable = true;

  # Smartd for HDDs
  services.smartd.enable = true;
  # Enable udisks to automount disks
  services.udisks2.enable = true;

  # Enable Virtualization
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "gideon" ]; # TODO remove hardcode
  virtualisation = {
    # Enable virtualization
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    # Docker
    docker.enable = true;
    oci-containers.backend = "docker";
  };

  # FlatPak Support
  services.flatpak.enable = true;
  # Enable AppImage Support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # enable fish systemwide
  programs.fish.enable = true;

  fonts.packages = with pkgs; [
    # collection of patched fonts
    nerd-fonts.hack
    #noto-fonts
    # symbols and emoji (outlined)
    #symbola
    noto-fonts-monochrome-emoji
    # chinese, japanese, korean
    #noto-fonts-cjk
    #noto-fonts-cjk-sans
    #noto-fonts-cjk-serif
    # Font Awesome
    font-awesome
    font-awesome_5
  ];

}
