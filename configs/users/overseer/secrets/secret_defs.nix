{ config, options, ... }: {

  age = {
    # The key used to decrypt secrets on boot
    identityPaths = [
      #"${config.home.homeDirectory}/nix/configs/users/overseer/configs/ssh/keys/athena-agenix"
      "/home/overseer/nix/configs/users/overseer/configs/ssh/keys/athena-agenix"
    ];
    # Where the secrets are found and deployed
    secrets = {
      traefik_env = {
        file = ./secrets/services/traefik/traefik_env.age;
        path = "${config.home.homeDirectory}/.secrets/services/traefik/.env";
      };
      nc_mysql_admin_pass = {
        file = ./secrets/services/nextcloud/nc_mysql_admin_pass.age;
        path =
          "${config.home.homeDirectory}/.secrets/services/nextcloud/nc_mysql_admin_pass";
        #mode = "640";
        owner = "nextcloud";
      };
    };
  };
}
