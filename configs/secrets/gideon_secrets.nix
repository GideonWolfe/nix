{ config, ... }: {
  sops.secrets = {
    "freshrss/apikey" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "weatherapi/apikey.json" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "wolfegideongmail/client_secret" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "wolfegideongmail/client_id" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "wolfegideongmail/mbsync_password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "gideonwolfexyz/mbsync_password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "gideonwolfecom/mbsync_password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "irc/libera/nick" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "irc/libera/password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "gideon";
    };
    "irc/weechat/sec.conf" = {
      sopsFile = ./gideon_secrets.yaml;
      path = "/home/gideon/.config/weechat/sec.conf";
      owner = "gideon";
    };
    "termsonic/termsonic.toml" = {
      sopsFile = ./gideon_secrets.yaml;
      path = "/home/gideon/.config/termsonic.toml";
      owner = "gideon";
    };
    "ssh/gideon_ssh_sk/private_key" = {
      sopsFile = ./gideon_secrets.yaml;
      path = "/home/gideon/.ssh/gideon_ssh_sk";
      owner = "gideon";
    };
  };
}
