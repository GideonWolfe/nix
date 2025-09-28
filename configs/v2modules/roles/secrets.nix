{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let 
  cfg = config.secrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.secrets = {
    enable = lib.mkEnableOption "SOPS secrets management infrastructure";

    defaultSopsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Default SOPS file to use for secrets";
      example = "../../../../secrets/secrets.yaml";
    };

    hostKeyPath = lib.mkOption {
      type = lib.types.str;
      default = "/etc/ssh/ssh_host_ed25519_key";
      description = "Path to the host SSH private key";
    };

    ageKeyFile = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sops-nix/key.txt";
      description = "Path where the AGE private key will be stored";
    };

    generateKey = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Automatically generate AGE key if it doesn't exist";
    };
  };

  config = lib.mkIf cfg.enable {

    # Ensure sops is available as a user command
    environment.systemPackages = with pkgs; [
      sops
    ];

    # SOPS configuration
    sops = {
      # Set default SOPS file if provided
      defaultSopsFile = cfg.defaultSopsFile;

      # Required to prevent bug from importing wrong keys
      gnupg.sshKeyPaths = [ ];

      # AGE key configuration
      age = {
        # Tell SOPS where to find the host private key
        # This will be used to go from Private SSH -> Private AGE key
        sshKeyPaths = [ cfg.hostKeyPath ];

        # This is where the host private AGE key lives
        keyFile = cfg.ageKeyFile;

        # If the private AGE key doesn't exist (like on a new system), create it
        generateKey = cfg.generateKey;
      };

      # Individual modules will define their own secrets directly via sops.secrets
      # No need to handle individual secrets here
    };
  };
}