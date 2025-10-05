{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let 
  cfg = config.custom.features.secrets;
in {
  imports = [
    # The import here makes the module available systemwide.
    # Even if the feature is disabled, we want the module to be available
    # so that modules won't break when referencing it
    inputs.sops-nix.nixosModules.sops
  ];

  # Enable the System Wide SOPS module
  # Doesn't do anything unless actual secrets are defined
  # By default, users import their own secrets in their user modules
  options.custom.features.secrets = {
    enable = lib.mkEnableOption "SOPS secrets management infrastructure";
  };

  config = lib.mkIf cfg.enable {
    # Ensure SSH is enabled so host keys get generated
    services.openssh.enable = lib.mkDefault true;

    # Ensure sops and age are available as user commands
    environment.systemPackages = with pkgs; [
      sops
      age
    ];

    # SOPS configuration
    sops = {
      # Required to prevent bug from importing wrong keys
      gnupg.sshKeyPaths = [ ];

      # AGE key configuration
      age = {
        # Tell SOPS where to find the host private key
        # This will be used to go from Private SSH -> Private AGE key
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

        # This is where the host private AGE key lives
        keyFile = "/var/lib/sops-nix/key.txt";

        # If the private AGE key doesn't exist (like on a new system), create it
        generateKey = true;
      };
    };

    # Create a helper service to display the AGE public key for this host
    systemd.services.sops-age-key-display = {
      description = "Display SOPS AGE public key for host configuration";
      wantedBy = [ "multi-user.target" ];
      # Remove the problematic after dependency since sops-nix.service doesn't exist
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = let
          displayScript = pkgs.writeShellScript "display-age-key" ''
            # Wait a bit to ensure the AGE key has been generated
            sleep 2
            if [ -f "/var/lib/sops-nix/key.txt" ]; then
              echo "============================================="
              echo "SOPS AGE Public Key for ${config.networking.hostName}"
              echo "============================================="
              echo "Public Key: $(${pkgs.age}/bin/age-keygen -y /var/lib/sops-nix/key.txt)"
              echo ""
              echo "Add this to your .sops.yaml:"
              echo "============================================="
              echo "keys:"
              echo "  - &hosts:"
              echo "      - &${config.networking.hostName} $(${pkgs.age}/bin/age-keygen -y /var/lib/sops-nix/key.txt)"
              echo ""
              echo "Then add ${config.networking.hostName} to the appropriate creation_rules"
              echo "============================================="
            else
              echo "AGE key file not found at /var/lib/sops-nix/key.txt"
              echo "This might be normal on first boot - try: systemctl restart sops-age-key-display"
            fi
          '';
        in "${displayScript}";
      };
    };
  };
}