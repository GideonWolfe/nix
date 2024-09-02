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
      vaultwarden_env = {
        file = ./secrets/services/vaultwarden/vaultwarden_env.age;
        path = "/secrets/services/vaultwarden/.env";
      };
      mealie_env = {
        file = ./secrets/services/mealie/mealie_env.age;
        path = "/secrets/services/mealie/.env";
      };
      saltrim_env = {
        file = ./secrets/services/saltrim/saltrim_env.age;
        path = "/secrets/services/saltrim/.env";
      };
      crowdsec_api_key = {
        file = ./secrets/services/crowdsec/crowdsec_api_key.age;
        path = "/var/lib/traefik/crowdsec_api_key";
        owner = "traefik";
      };
    };
  };
}
