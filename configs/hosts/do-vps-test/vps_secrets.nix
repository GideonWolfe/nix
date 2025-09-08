{ config, ... }: {
  sops.secrets = {
    "grafana/hint" = {
      sopsFile = ./vps_secrets.yaml;
      owner = "root";
    };
  };
}
