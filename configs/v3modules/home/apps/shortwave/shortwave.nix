{ pkgs, lib, config, ... }:

# BUG: this doesn't work, idk how to get the program to be able to download stuff
{
  dconf.settings."de/haeckerfelix/Shortwave" = {
    recorder-song-save-path = config.xdg.userDirs.download;
  };
}
