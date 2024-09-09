{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      "${config.home.homeDirectory}/nix/configs/users/gideon/configs/ssh/keys/agenix-gideon"
      #"/home/gideon/nix/configs/users/gideon/configs/ssh/keys/agenix-gideon"
    ];
    # Where the secrets are found and deployed
    secrets = {
      test_users_secret = {
        file = ./secrets/test/test_users_secret.age;
        path =
          "${config.home.homeDirectory}/.test_secrets/test/test_users_secret";
      };
    };
  };
}
