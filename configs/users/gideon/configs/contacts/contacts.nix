{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  accounts.contact = {
    basePath = "${config.home.homeDirectory}/contacts/";
    accounts = {
      gmail = {

        # Define how the calendar is stored locally
        local = {
          path = "${config.home.homeDirectory}/contacts/gmail";
          type = "filesystem";
          fileExt = ".vcf";
        };
        # Define the remote calendar
        remote = { type = "google_contacts"; };

        # Define how the calendars are synced
        vdirsyncer = {
          enable = true;
          clientIdCommand =
            #[ "cat" "${config.age.secrets.vdirsyncer_google_client_id.path}" ];
            [
              "cat"
              "${config.sops.secrets."wolfegideongmail/client_id".path}"
            ];
          clientSecretCommand = [
            "cat"
            "${config.sops.secrets."wolfegideongmail/client_secret".path}"
          ];
          #               [
          #   "cat"
          #   "${config.age.secrets.vdirsyncer_google_client_secret.path}"
          # ];
          # set remote calendar as source of truth
          conflictResolution = "remote wins";
          collections = [ "from a" "from b" ];
          tokenFile = "${config.home.homeDirectory}/contacts/tokenfile";
        };
        # TODO: Khard can't recursively search since google creates a "default" subdir that khard doesn't look in
        # They should add a setting to specify hardcoded collections in the base dir
        # https://github.com/nix-community/home-manager/pull/5220
        # https://github.com/nix-community/home-manager/issues/4531
        khard = {
          enable = true;
          defaultCollection = "default";
        };

        # Experimenting: allow Khal to scan contacts for birthdays
        khal = {
          enable = true;
          collections = [ "default" ];
          color = "${base0B}";
        };

        # TODO: https://github.com/nix-community/home-manager/pull/5484
        # Should be able to enable for thunderbird soon!

      };
    };
  };
}
