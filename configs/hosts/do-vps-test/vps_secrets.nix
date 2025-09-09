{ config, ... }: {
  sops.secrets = {
    "grafana/hint" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "grafana";
    };
    "traefik/env" = { 
      sopsFile = ./vps_secrets.yaml; 
    };
  };
}
