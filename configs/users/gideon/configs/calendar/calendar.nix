{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  accounts.calendar = {
    basePath = "${config.home.homeDirectory}/calendars/";
    accounts = {
      gmail = {
        primary = true;
        primaryCollection =
          "wolfegideon@gmail.com"; # this will be the default_calendar in khal
        name = "wolfegideon@gmail.com";
        # Define how the calendar is stored locally
        local = {
          path = "${config.home.homeDirectory}/calendars/gmail";
          type = "filesystem";
          fileExt = ".ics";
        };
        # Define the remote calendar
        remote = { type = "google_calendar"; };

        # Define how the calendars are synced
        vdirsyncer = {
          enable = true;
          clientIdCommand =
            [ "cat" "${config.age.secrets.vdirsyncer_google_client_id.path}" ];
          clientSecretCommand = [
            "cat"
            "${config.age.secrets.vdirsyncer_google_client_secret.path}"
          ];
          # set remote calendar as source of truth
          conflictResolution = "remote wins";
          collections = [ "from a" "from b" ];
          tokenFile = "${config.home.homeDirectory}/calendars/tokenfile";
        };

        # TODO: https://github.com/nix-community/home-manager/pull/5484
        # Should be able to enable for thunderbird soon!
        khal = {
          enable = true;
          type = "discover";
          color = "${blue}";
        };
      };
    };
  };
}
