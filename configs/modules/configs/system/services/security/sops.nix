{ config, lib, pkgs, inputs, ... }:

{

  # Making sure we have this import, even though it's passed
  # in through the core system config
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    # Tell SOPS where to find secrets
    # This will be the same on every system
    #defaultSopsFile = ../../../../secrets/secrets.yaml;
    #defaultSopsFile = ../../../../secrets/gideon_secrets.yaml;

    # required to prevent bug from importing wrong keys
    gnupg.sshKeyPaths = [ ];

    age = {
      # Tell SOPS where to find the host private key
      # This will be the same on each system, autogenerated by nix
      # This will be used to go from Private SSH -> Private AGE key
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      # This is where the host private AGE key lives
      keyFile = "/var/lib/sops-nix/key.txt";

      # If the private AGE key doesn't exist (like on a new system), create it
      generateKey = true;

    };
  };
}
