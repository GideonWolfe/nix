{ pkgs, lib, config, ... }:

{
  services.vaultwarden = {
    enable = true;
    backupDir = "/backups/passwords/";
    #environmentFile = "/secrets/services/vaultwarden/.env";
    #environmentFile = "${config.age.secrets.vaultwarden_env.path}";
    environmentFile = "${config.sops.secrets."vaultwarden/env".path}";
    config = {
      SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "::";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };

  services.restic.backups.vaultwarden = {
    initialize = true;
    repository = "/run/media/overseer/mnemosyne/backups/passwords/vaultwarden/";
    paths = [ "/backups/passwords" ];
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
