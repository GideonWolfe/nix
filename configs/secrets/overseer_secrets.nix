{ config, ... }: {
  sops.secrets = {
    "freshrss/apikey" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "weatherapi/apikey.json" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "wolfegideongmail/client_secret" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "wolfegideongmail/client_id" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "wolfegideongmail/mbsync_password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "gideonwolfexyz/mbsync_password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "gideonwolfecom/mbsync_password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "irc/libera/nick" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "irc/libera/password" = {
      sopsFile = ./gideon_secrets.yaml;
      owner = "overseer";
    };
    "irc/weechat/sec.conf" = {
      sopsFile = ./gideon_secrets.yaml;
      path = "/home/overseer/.config/weechat/sec.conf";
      owner = "overseer";
    };
    "termsonic/termsonic.toml" = {
      sopsFile = ./gideon_secrets.yaml;
      path = "/home/overseer/.config/termsonic.toml";
      owner = "overseer";
    };
    "ssh/gideon_ssh_sk/private_key" = {
      sopsFile = ./gideon_secrets.yaml;
      path = "/home/overseer/.ssh/gideon_ssh_sk";
      owner = "overseer";
    };
  };
}
