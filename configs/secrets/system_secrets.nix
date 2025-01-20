{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    # Where the secrets are found and deployed
    secrets = {
      # Secrets for Homeserver
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
      paperless_admin_pass = {
        file = ./secrets/services/paperless/paperless_admin_pass.age;
        path = "/secrets/services/paperless/paperless_admin_pass";
      };
      crowdsec_api_key = {
        file = ./secrets/services/crowdsec/crowdsec_api_key.age;
        path = "/var/lib/traefik/crowdsec_api_key";
        owner = "traefik";
      };
    };
  };
}
