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
        path =
          "${config.home.homeDirectory}/.secrets/calendar/vdirsyncer/vdirsyncer_google_client_id";
      };
      vdirsyncer_google_client_secret = {
        file =
          ./secrets/calendar/vdirsyncer/vdirsyncer_google_client_secret.age;
        path =
          "${config.home.homeDirectory}/.secrets/calendar/vdirsyncer/vdirsyncer_google_client_secret";
      };
      mbsync_google_wolfegideon_app_password = {
        file = ./secrets/email/gmail/mbsync_google_wolfegideon_app_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/email/gmail/mbsync_google_wolfegideon_app_password";
      };
      mbsync_gideonwolfexyz_password = {
        file = ./secrets/email/gideonwolfexyz/mbsync_gideonwolfexyz_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/email/gideonwolfexyz/mbsync_gideonwolfexyz_password";
      };
      mbsync_gideonwolfecom_password = {
        file = ./secrets/email/gideonwolfecom/mbsync_gideonwolfecom_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/email/gideonwolfecom/mbsync_gideonwolfecom_password";
      };
      weechat_libera_password= {
        file = ./secrets/irc/weechat/weechat_libera_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/irc/weechat/weechat_libera_password";
      };
      newsboat_config= {
        file = ./secrets/newsboat/newsboat_config.age;
        path =
          "${config.home.homeDirectory}/.config/newsboat/config";
      };
    };
  };
}
