{ pkgs, lib, stylix, config, sops-nix, ... }:

{
  # better place to move these definitions?
  sops = {
    defaultSopsFile = ../../../../secrets/gideon_secrets.yaml;

    # Point to user GPG directory (where we've automatically added our public key)
    gnupg.home = "${config.home.homeDirectory}/.gnupg";

    secrets."freshrss/apikey" = { };
    secrets."weatherapi/apikey.json" = { };
    secrets."wolfegideongmail/client_secret" = { };
    secrets."wolfegideongmail/client_id" = { };
    secrets."wolfegideongmail/mbsync_password" = { };
    secrets."gideonwolfexyz/mbsync_password" = { };
    secrets."gideonwolfecom/mbsync_password" = { };
    secrets."irc/libera/nick" = { };
    secrets."irc/libera/password" = { };
    secrets."irc/weechat/sec.conf" = {
      path = "${config.home.homeDirectory}/.config/weechat/sec.conf";
    };
    secrets."termsonic/termsonic.toml" = {
      path = "${config.home.homeDirectory}/.config/termsonic.toml";
    };
    secrets."ssh/gideon_ssh_sk/private_key" = {
      path = "${config.home.homeDirectory}/.ssh/gideon_ssh_sk";
    };
  };

}
