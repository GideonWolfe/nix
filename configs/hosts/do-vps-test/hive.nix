{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    colmena.url = "github:zhaofengli/colmena";
    main.url = "path:/home/gideon/nix"; # Path to your main flake
    disko.url = "github:nix-community/disko/latest";

  };

  outputs = { self, nixpkgs, colmena, main, disko }:
    colmena.lib.makeHive {
      meta.nixpkgs = import nixpkgs { system = "x86_64-linux"; };

      do-vps-test = { name, nodes, pkgs, ... }: {
        # Import the actual configuration file and required modules
        imports = [
          disko.nixosModules.disko
          #"${main}/configs/modules/keys/ssh.nix" # This defines local.ssh.keys
          #"${main.url}/configs/hosts/do-vps-test/configuration.nix"
          "./configuration.nix"
        ];

        # Deployment settings
        deployment = {
          targetHost = "165.227.70.3";
          targetPort = 22;
          targetUser = "gideon";
          sshOptions = [ "-i" "/home/gideon/.ssh/gideon_ssh_sk" ];
        };
      };

    };
}
