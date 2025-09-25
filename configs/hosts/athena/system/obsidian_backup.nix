{ config, lib, pkgs, ... }:

# Automatically backing up my music library

{
  services.restic.backups.obsidian_vault_gideon = {
    initialize = true;
    repository = "/run/media/overseer/mnemosyne/backups/notes/obsidian/gideon/";
    paths = [ "/home/overseer/notes/gideon" ];
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
