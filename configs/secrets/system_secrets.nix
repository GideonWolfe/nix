{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    # Where the secrets are found and deployed
    secrets = {
      test_systems_secret = {
        file = ./secrets/test/test_systems_secret.age;
        path =
          "/test_secrets/test/test_systems_secret";
      };
    };
  };
}
