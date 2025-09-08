{
  meta = {
    nixpkgs = import <nixpkgs> { system = "x86_64-linux"; };
  };

  do-vps-test = { name, nodes, pkgs, ... }: {
    # Import your existing configuration (disko is optional now)
    imports = [
      ./configuration.nix
      ../../modules/keys/ssh.nix
    ];

    # Deployment settings for colmena
    deployment = {
      targetHost = "165.227.70.3";
      targetPort = 22;
      targetUser = "root";
      privilegeEscalationCommand = []; # Disable sudo since we're using root
      sshOptions = [ "-i" "/home/gideon/.ssh/gideon_ssh_sk" ];
    };
  };
}
