{ config, ... }: {
  sops.secrets = {
    "crowdsec/api_key" = {
      sopsFile = ./athena_secrets.yaml;
      path = "/var/lib/traefik/crowdsec_api_key";
      owner = "traefik";
    };
    "mealie/env" = { sopsFile = ./athena_secrets.yaml; };
    "paperless/admin_pass" = { sopsFile = ./athena_secrets.yaml; };
    "romm/env" = { sopsFile = ./athena_secrets.yaml; };
    "traefik/env" = { sopsFile = ./athena_secrets.yaml; };
    "vaultwarden/env" = { sopsFile = ./athena_secrets.yaml; };
  };
}
