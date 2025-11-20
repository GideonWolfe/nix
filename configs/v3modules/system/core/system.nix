{ config, lib, pkgs, inputs, ... }:

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


    ##################################### #
    # Import options for our custom roles #
    ##################################### #
    # Provide the option to enable monitoring
    ../roles/monitoring/monitoring.nix
    # Provide the option to enable gaming
    ../roles/gaming/gaming.nix
    # Provide the option to enable music production
    ../roles/music_production/music_production.nix
    # Provide the option to enable hardware support.
    # Should be used if system isn't a VPS. Enabled by default
    ../roles/hardware/hardware.nix


  ];

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # disable docs to speed builds
  documentation.nixos.enable = false;

  nix.settings.trusted-users = [ "root" "gideon" ];

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

  # Greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time  --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session";
        user = "greeter";
      };
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

  # Enable gnome-keyring
  services.gnome.gnome-keyring.enable = true;
  # Give seahorse access to GNOME Keyring
  programs.seahorse.enable = true;

  # Enable GPG Agent
  programs.gnupg.agent.enable = true;
  # Enable hardware support for GPG smartcards
  hardware.gpgSmartcards.enable = true;

  # required for sway according to docs
  security.polkit.enable = true;
  # Required for swaylock to work
  security.pam.services.swaylock = { text = "	auth include login\n"; };

  # Enable Sound
  services.pipewire = {
    # Enable Pipewire
    enable = true;
    # Use Pipewire as primary server
    audio.enable = true;
    # Enable wireplummber session manager
    wireplumber.enable = true;
    # Handle other audio servers too
    jack.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable D-Bus
  services.dbus.enable = true;

  # Enable Network Manager
  networking.networkmanager.enable = true;
  # Enable tray applet
  programs.nm-applet.enable = true;
  
  # Set Timezone Automatically
  services.automatic-timezoned.enable = true;

  
  # Smartd for HDDs
  services.smartd.enable = true;
  # Enable udisks to automount disks
  services.udisks2.enable = true;


  # Enable Virtualization
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "gideon" ]; #TODO remove hardcode
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable docker daemon
  virtualisation.docker.enable = true;
  # Choose docker as the backend for OCI containers configured via nix
  virtualisation.oci-containers.backend = "docker";

  
  # Make XDG Portals available
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.lxqt.xdg-desktop-portal-lxqt
    ];
  };
  xdg.portal.wlr.enable = true;
  xdg.portal.lxqt.enable = true;

  # FlatPak Support
  services.flatpak.enable = true;
  # Enable AppImage Support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # enable fish systemwide
  programs.fish.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

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
