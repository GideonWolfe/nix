{ config, lib, pkgs, osConfig, ... }:

{
  imports = [
    ## General user settings
    ../../home/base.nix

    # User Specific Settings  
    ./configs/ssh.nix
    ./configs/gpg.nix
    ./configs/git.nix
    # Email stuff
    ./configs/email/neomutt/neomutt.nix
    ./configs/email/thunderbird/thunderbird.nix # uses lots of storage
    ./configs/email/email.nix
    ./configs/email/mbsync.nix
    # calendar settings and sync
    ./configs/calendar/calendar.nix
    ./configs/calendar/khal.nix
    ./configs/calendar/calcure.nix
    # contacts settings and sync
    ./configs/contacts/contacts.nix
    ./configs/contacts/khard.nix
  ];
  
  # Put my profile image in the usual spot
  home.file."profile.png".source = ./profile.png;
  
  # Always import my PGP public key into user config
  # HANDLED FROM ABOVE IMPORT NOW
  # programs.gpg.publicKeys = [{ 
  #   source = ./keys/gideon_pub.asc;
  # }];

  home.stateVersion = "23.11";
}
