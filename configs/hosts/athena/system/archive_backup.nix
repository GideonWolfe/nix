{ config, lib, pkgs, ... }:

# Automatically backing up my music library

{
  services.restic.backups.archives = {
    initialize = true;
    repository = "/run/media/overseer/mnemosyne/backups/archives/";
    paths = [ "/home/overseer/test/archives" ];
    passwordFile =
      "/run/media/overseer/mnemosyne/backuppass.txt"; # TODO:  replace this with secret

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true; # remembers last run, runs if missed
    };
    runCheck = true;
    checkOpts = [ "--read-data" ];
  };
}
