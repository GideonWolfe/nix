{ pkgs, lib, stylix, config, ... }:

{
  programs.gpg.publicKeys = [{ 
    source = ../keys/gideon_pub.asc;
  }];
}
