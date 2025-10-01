{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let 
  cfg = config.custom.features.secrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ../../secrets/gideon_secrets.nix
  ];

  options.custom.features.secrets = {
    enable = lib.mkEnableOption "SOPS secrets management infrastructure";

    defaultSopsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null; # Don't set by default to avoid chicken-and-egg problem
      description = "Default SOPS file to use for secrets (set after AGE key is generated)";
      example = "../../../../secrets/gideon_secrets.yaml";
    };

    useUserSecretsFile = lib.mkOption {
      type = lib.types.bool;
      default = false; # Don't auto-use user secrets until key is added to .sops.yaml
      description = "Whether to automatically use the user's secrets file as defaultSopsFile";
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
    # Ensure sops and age are available as user commands
    environment.systemPackages = with pkgs; [
      sops
      age
    ];

    # SOPS configuration
    sops = {
      # Only set default SOPS file if explicitly provided or useUserSecretsFile is enabled
      defaultSopsFile = 
        if cfg.defaultSopsFile != null then cfg.defaultSopsFile
        else if cfg.useUserSecretsFile && config.custom.user.secretsFile != null then config.custom.user.secretsFile
        else null;

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
    };

    # Create a helper service to display the AGE public key for this host
    systemd.services.sops-age-key-display = lib.mkIf cfg.generateKey {
      description = "Display SOPS AGE public key for host configuration";
      wantedBy = [ "multi-user.target" ];
      after = [ "sops-nix.service" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = let
          displayScript = pkgs.writeShellScript "display-age-key" ''
            if [ -f "${cfg.ageKeyFile}" ]; then
              echo "============================================="
              echo "SOPS AGE Public Key for ${config.networking.hostName}"
              echo "============================================="
              echo "Public Key: $(${pkgs.age}/bin/age-keygen -y ${cfg.ageKeyFile})"
              echo ""
              echo "Add this to your .sops.yaml:"
              echo "============================================="
              echo "keys:"
              echo "  - &hosts:"
              echo "      - &${config.networking.hostName} $(${pkgs.age}/bin/age-keygen -y ${cfg.ageKeyFile})"
              echo ""
              echo "Then add ${config.networking.hostName} to the appropriate creation_rules"
              echo "============================================="
            else
              echo "AGE key file not found at ${cfg.ageKeyFile}"
            fi
          '';
        in "${displayScript}";
      };
    };
  };
}