{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      "${config.home.homeDirectory}/nix/configs/users/gideon/configs/ssh/keys/agenix-gideon"
      #"/home/gideon/nix/configs/users/gideon/configs/ssh/keys/agenix-gideon"
    ];
    # Where the secrets are found and deployed
    secrets = {
      # Secrets for gideon
      vdirsyncer_google_client_id = {
        file =
          ./secrets/users/gideon/calendar/vdirsyncer/vdirsyncer_google_client_id.age;
        path =
          "${config.home.homeDirectory}/.secrets/calendar/vdirsyncer/vdirsyncer_google_client_id";
      };
      vdirsyncer_google_client_secret = {
        file =
          ./secrets/users/gideon/calendar/vdirsyncer/vdirsyncer_google_client_secret.age;
        path =
          "${config.home.homeDirectory}/.secrets/calendar/vdirsyncer/vdirsyncer_google_client_secret";
      };
      mbsync_google_wolfegideon_app_password = {
        file =
          ./secrets/users/gideon/email/gmail/mbsync_google_wolfegideon_app_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/email/gmail/mbsync_google_wolfegideon_app_password";
      };
      mbsync_gideonwolfexyz_password = {
        file =
          ./secrets/users/gideon/email/gideonwolfexyz/mbsync_gideonwolfexyz_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/email/gideonwolfexyz/mbsync_gideonwolfexyz_password";
      };
      mbsync_gideonwolfecom_password = {
        file =
          ./secrets/users/gideon/email/gideonwolfecom/mbsync_gideonwolfecom_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/email/gideonwolfecom/mbsync_gideonwolfecom_password";
      };
      # file used by weechat to abstract secrets into
      weechat_sec_conf = {
        file = ./secrets/users/gideon/irc/weechat/weechat_sec_conf.age;
        path = "${config.home.homeDirectory}/.config/weechat/sec.conf";
      };
      freshrss_api_key = {
        file = ./secrets/users/gideon/rss/freshrss_api_key.age;
        path = "${config.home.homeDirectory}/.secrets/rss/freshrss_api_key";
      };
      weatherapi_api_key = {
        file = ./secrets/users/gideon/infra/weatherapi_api_key.age;
        path =
          "${config.home.homeDirectory}/.secrets/infra/weatherapi_api_key.json";
      };
    };
  };
}
