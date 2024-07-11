{ config, lib, pkgs, ... }:

{
  #TODO: template this out, possibly reference variable?
  networking.hostName = "hermes"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";
  #services.automatic-timezoned.enable = true;

  # Enable fish shell
  #programs.fish.enable = true;

  # Configure system level fonts
  fonts.fontconfig = {
    defaultFonts = { emoji = [ "Noto Emoji" "Symbola" ]; };
  };

  # Option for enabling CKB next
  # TODO build a conditional to only run if corsair detected
  #hardware.ckb-next.enable = true;

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

}
