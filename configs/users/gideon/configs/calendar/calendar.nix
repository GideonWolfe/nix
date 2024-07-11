{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  accounts.calendar = {
    basePath = "${config.home.homeDirectory}/calendars/";
    accounts = {
      gmail = {
        primary = true;
        local = {
          path = "${accounts.calendar.basePath}/gmail";
          type = "filesystem";
        };
        remote = {
            type = "google_calendar";
            url = ""; #TODO: 
            userName = "";
            passwordCommand = "";
        };
      };
    };
  };
}
