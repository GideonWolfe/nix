# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ###########
      # CONFIGS #
      ###########

      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # General System Settings
      ./system/system/system.nix

      # Login manager/greeter
      ./system/services/greeter.nix

      # System level theming
      ./system/graphics/stylix.nix

      # Networking and Bluetooth
      ./system/services/networks/networking.nix
      ./system/services/networks/bluetooth.nix
      ./system/services/networks/ssh.nix

      # Docker
      ./system/services/docker.nix

      # Printer support
      ./system/services/printing.nix

      # UI
      ./system/graphics/hyprland.nix
      ./system/graphics/wayland.nix

      # Audio
      ./system/services/audio/pipewire.nix

      ############
      # PACKAGES #
      ############

      # Audio
      ./system/packages/audio.nix

      # Video
      ./system/packages/video.nix

      # Development
      ./system/packages/development.nix

      # Networking
      ./system/packages/networking.nix

      # Graphics
      ./system/packages/ui.nix

      # System
      ./system/packages/system.nix
    ];

  #stylix.image = ./system/graphics/zT7uCe2.png;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hermes"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  programs.fish.enable = true;

  # required for sway according to docs
  security.polkit.enable = true;

  # Required for swaylock to work
  security.pam.services.swaylock = {
	text = ''
		auth include login
	'';
  };

  #hardware.opengl.enable = true;

  services.weechat.enable = false;

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  # TODO required for Hyprland to run, but causes lag. even in Sway when it was snappy before
  #environment.sessionVariables = rec {
  #  WLR_RENDERER_ALLOW_SOFTWARE = "1";
  #};

  # list of programs I want to execute WITHOUT passwd (ie from waybar)
  security.sudo = {
	enable = true;
	extraRules = [
		{

			groups = ["wheel"];
			commands = [
				{
					command = "/run/current-system/sw/bin/iotop";
					options = ["NOPASSWD"];
				}
			];
		}
	];
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gideon = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      neovim
      tree
    ];
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  programs.hyprland.enable = true;

}

