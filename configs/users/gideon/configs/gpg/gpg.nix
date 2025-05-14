{ pkgs, lib, config, ... }:

{
  programs.gpg = {
    enable = true;
    # Always import my PGP public key into user config
    publicKeys = {
            "gideon_pub".path = ../gideon_pub.asc;
        };
  };
}
