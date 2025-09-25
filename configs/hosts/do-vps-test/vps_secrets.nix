{ config, ... }: {
  sops.secrets = {
    "grafana/hint" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "grafana";
    };
    "grafana/users/admin/username" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "grafana";
    };
    "grafana/users/admin/password" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "grafana";
    };
    "grafana/smtp/host" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "grafana";
    };
    "grafana/smtp/password" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "grafana";
    };
    "traefik/env" = { 
      sopsFile = ./vps_secrets.yaml; 
    };
  };
}
