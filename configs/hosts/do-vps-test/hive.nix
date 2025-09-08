{
  meta = {
    nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz") { system = "x86_64-linux"; };
  };

  do-vps-test = { name, nodes, pkgs, config, ... }: {
    # Import your existing configuration (disko is optional now)
    imports = [
      ../../modules/keys/ssh.nix
      ../../modules/world.nix
      ./configuration.nix
      ./grafana.nix
    ];

    # Deployment settings for colmena
    deployment = {
      targetHost = config.local.world.hosts.monitor.ip;
      targetPort = 22;
      targetUser = "root";
      privilegeEscalationCommand = []; # Disable sudo since we're using root
      sshOptions = [ "-i" "/home/gideon/.ssh/gideon_ssh_sk" ];
    };
  };
}
