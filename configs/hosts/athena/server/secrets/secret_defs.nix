{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      "${config.home.homeDirectory}/nix/configs/users/gideon/configs/ssh/keys/agenix-gideon"
    ];
    # Where the secrets are found and deployed
    secrets = {
      weechat_libera_password= {
        file = ./secrets/irc/weechat/weechat_libera_password.age;
        path =
          "${config.home.homeDirectory}/.secrets/irc/weechat/weechat_libera_password";
      };
    };
  };
}
