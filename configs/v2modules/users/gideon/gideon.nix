{ config, lib, pkgs, ... }:

{
  # Gideon user definition - self-contained
  options.custom.userPresets.gideon = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
    default = {
      name = "gideon";
      home = "/home/gideon";
      shell = pkgs.fish;
      #initialPassword = "test"; # For testing only
      initialHashedPassword = "$6$vfx95FxcFJ8bw1vC$vYI9YPln6V/rm3hV9XT/FiK1tsP64O78KsSFgF9Auk7xbGmdaXDY5A49nXZ77wIArh19RuPQ1SdzP2Nd/lzhi.";
      extraGroups = [
        "wheel"     # Enable 'sudo' for the user
        "docker"    # Let the user run docker commands  
        "dialout"   # let programs run by the user (like chirp) access USB ports
        "input"     # let programs run by the user (like chirp) access touchpad input (for fusuma gestures)
        "i2c"       # allow the user to control i2c devices like external displays through ddc
        "plugdev"   # needed for RTL-SDR
        "storage"   # needed for udisks/udiskie
      ];
      #packages = with pkgs; [ firefox tree ];
      openssh.authorizedKeys = [
        # Yubikey Public Key - read from file
        (lib.strings.removeSuffix "\n" (builtins.readFile ./keys/gideon_ssh_sk.pub))
      ];
      profilePicture = ./profile.png;
      secretsFile = ../../../secrets/gideon_secrets.yaml;

      # Additional home-manager config specific to gideon can go here
      homeManagerConfig = {
        imports = [
          # General user settings
          ../../configs/user/common.nix
          # User Specific SSH Settings
          ./configs/ssh.nix
        ];
        home.stateVersion = "23.11";
        # Always import my PGP public key into user config
        programs.gpg.publicKeys = [{ source = ./keys/gideon_pub.asc; }];
      };
    };
    description = "Gideon user preset configuration";
  };
}
