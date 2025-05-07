{ config, lib, pkgs, ... }:

#let backupRoot = "/test/backup/target";
#in 
{
  services.restic = {

    # Configuration for the restic server
    server = {
      enable = false;
      prometheus = true;
      # The root of all our backed up files
      #dataDir = "/test/backup";
    };

    backups.gideontest = {
      # Automatically create repository for this backup
      initialize = true;
      # The destination of the backup operation
      repository = "/test/backup/gideontest";
      # The path that will be backed up
      paths = [ "/home/gideon/test/backup/source" ];
      # The file containing the password to the remote repository
      passwordFile =
        "/home/gideon/nix/configs/modules/configs/system/services/testpass.txt";
      # How often the backup job should be run
      timerConfig = {
        #OnCalendar = "daily";
        OnCalendar = "*:0/1"; # runs every min
        Persistent = true; # remembers last run, runs if missed
      };

      # Perform validation checks on data
      runCheck = true;
      checkOpts = [ "--read-data" ];
    };
  };
}
