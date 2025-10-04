{ config, lib, pkgs, osConfig, ... }:

{
  imports = [
    ## General user settings
    #../../configs/user/common.nix
    # User Specific SSH Settings  
    ./configs/ssh.nix
  ];
  
  
  # Always import my PGP public key into user config
  programs.gpg.publicKeys = [{ 
    source = ./keys/gideon_pub.asc;
  }];

  home.stateVersion = "23.11";
}
