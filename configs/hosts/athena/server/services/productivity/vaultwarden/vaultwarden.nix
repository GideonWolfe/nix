{ pkgs, lib, config, ... }:

{
    services.vaultwarden = {
        enable = true;
        backupDir = "/backups/passwords/";
        environmentFile = "/secrets/services/vaultwarden/.env";
        config = {
            SIGNUPS_ALLOWED = false;
              ROCKET_ADDRESS = "::";
              ROCKET_PORT = 8222;
              ROCKET_LOG = "critical";
        };
    };
}
