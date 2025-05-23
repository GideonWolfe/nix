{ config, ... }: {
  sops.secrets = {
    "freshrss/apikey" = { 
            sopsFile = ./gideon_secrets.yaml; 
            owner = "gideon";
        };
    "weatherapi/apikey.json" = { sopsFile = ./gideon_secrets.yaml; };
    "wolfegideongmail/client_secret" = { sopsFile = ./gideon_secrets.yaml; };
    "wolfegideongmail/client_id" = { sopsFile = ./gideon_secrets.yaml; };
    "wolfegideongmail/mbsync_password" = { sopsFile = ./gideon_secrets.yaml; };
    "gideonwolfexyz/mbsync_password" = { sopsFile = ./gideon_secrets.yaml; };
    "gideonwolfecom/mbsync_password" = { sopsFile = ./gideon_secrets.yaml; };
    "irc/libera/nick" = { sopsFile = ./gideon_secrets.yaml; };
    "irc/libera/password" = { sopsFile = ./gideon_secrets.yaml; };
    "irc/weechat/sec.conf" = {
      sopsFile = ./gideon_secrets.yaml;
      #path = "${config.home.homeDirectory}/.config/weechat/sec.conf";
      path = "/home/gideon/.config/weechat/sec.conf";
    };
    "termsonic/termsonic.toml" = {
      sopsFile = ./gideon_secrets.yaml;
      #path = "${config.home.homeDirectory}/.config/termsonic.toml";
      path = "/home/gideon/.config/termsonic.toml";
    };
    "ssh/gideon_ssh_sk/private_key" = {
      sopsFile = ./gideon_secrets.yaml;
      #path = "${config.home.homeDirectory}/.ssh/gideon_ssh_sk";
      path = "/home/gideon/.ssh/gideon_ssh_sk";
    };
  };
}
