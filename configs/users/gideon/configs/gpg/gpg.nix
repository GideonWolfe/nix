{ pkgs, lib, config, ... }:

{
  programs.gpg = {
    enable = true;
    # Always import my PGP public key into user config
    publicKeys = [{ source = ../gideon_pub.asc; }];
    scdaemonSettings = {disable-ccid = true;}; # tell GPG to not use its own cardreader daemon and use PC/SC instead
  };
}
