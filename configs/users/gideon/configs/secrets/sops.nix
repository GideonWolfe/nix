{ pkgs, lib, stylix, config, sops-nix, ... }:

{
  # better place to move these definitions?
  sops = {
    defaultSopsFile = ../../../../secrets/gideon_secrets.yaml;

    # Point to user GPG directory (where we've automatically added our public key)
    gnupg.home = "${config.home.homeDirectory}/.gnupg";

    secrets."freshrss/apikey" = { };
  };

}
