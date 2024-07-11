{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      "${config.home.homeDirectory}/nix/configs/users/gideon/configs/ssh/keys/agenix-gideon"
    ];
    # Where the secrets are found and deployed
    secrets = {
      vdirsyncer_google_client_id = {
        file = ./secrets/calendar/vdirsyncer/vdirsyncer_google_client_id.age;
        path = "${config.home.homeDirectory}/.secrets/calendar/vdirsyncer/vdirsyncer_google_client_id";
      };
      vdirsyncer_google_client_secret = {
        file =
          ./secrets/calendar/vdirsyncer/vdirsyncer_google_client_secret.age;
        path = "${config.home.homeDirectory}/.secrets/calendar/vdirsyncer/vdirsyncer_google_client_secret";
      };
    };
  };
}
