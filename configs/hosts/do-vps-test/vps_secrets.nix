{ config, ... }: {
  sops.secrets = {
    "vps_test_secret" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
  };
}
