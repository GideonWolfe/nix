{ pkgs, lib, config, ... }:

{
  programs.gpg = {
    enable = true;
    scdaemonSettings = {disable-ccid = true;}; # tell GPG to not use its own cardreader daemon and use PC/SC instead
  };
}
