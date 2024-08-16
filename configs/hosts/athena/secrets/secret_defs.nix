{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    # Where the secrets are found and deployed
    secrets = {
      traefik_env = {
        file = ./secrets/services/traefik/traefik_env.age;
        path = "/secrets/services/traefik/.env";
      };
    };
  };
}
