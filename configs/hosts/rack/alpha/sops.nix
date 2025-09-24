{ config, lib, pkgs, ... }:

{
  imports = [
    # sets up basic stuff like autogenerating key, etc
    ../../../modules/configs/system/services/security/sops.nix
    

    # importing the definitions for which secrets we want to deploy
    ../../../secrets/gideon_secrets.nix
  ];

  #INFO: if the host has host-specific secrets, it should be set to that file
  # gideon_secrets already explicitly declares which sops file to use
  sops.defaultSopsFile = ../../../../secrets/gideon_secrets.yaml;
  # sops.defaultSopsFile = ./poseidon-secrets.yaml;
  # sops.secrets.someHostSpecificSecret = { };
}
