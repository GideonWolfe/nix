{ config, lib, pkgs, ... }:

{
  imports = [
    # Import gideon's secrets when this user is enabled
    ../../../secrets/gideon_secrets.nix
  ];

  # Configuration for the Gideon user on a SYSTEM level
  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    shell = pkgs.fish;
    initialHashedPassword = "$6$vfx95FxcFJ8bw1vC$vYI9YPln6V/rm3hV9XT/FiK1tsP64O78KsSFgF9Auk7xbGmdaXDY5A49nXZ77wIArh19RuPQ1SdzP2Nd/lzhi.";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker" # Let the user run docker commands
      "dialout" # let programs run by the user (like chirp) access USB ports
      "input" # let programs run by the user (like chirp) access touchpad input (for fusuma gestures)
      "i2c"       # allow the user to control i2c devices like external displays through ddc
      "plugdev" # for RTL-SDR
      "storage" # for udiskie
    ];
    #packages = with pkgs; [ firefox vim tree ];

    # Automatically import my SSH key
    # This associates this keypair wih this user, allowing it to authenticate me
    openssh.authorizedKeys.keys = [
      # Yubikey Public Key - read from file
      (lib.strings.removeSuffix "\n" (builtins.readFile ./keys/gideon_ssh_sk.pub))
    ];
  };

  # Test: Associate the secrets file with this user module
  sops.defaultSopsFile = ../../../secrets/gideon_secrets.yaml;

  # Allow gideon to copy closures (trusted user for nix operations)
  nix.settings.trusted-users = [ "gideon" ];
}