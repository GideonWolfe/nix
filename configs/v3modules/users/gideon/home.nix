{ config, lib, pkgs, osConfig, ... }:

{
  imports = [
    ## General user settings
    ../../home/common.nix

    # User Specific Settings  
    ./configs/ssh.nix
    ./configs/gpg.nix
    ./configs/git.nix

    # Package imports
    ./packages.nix
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
