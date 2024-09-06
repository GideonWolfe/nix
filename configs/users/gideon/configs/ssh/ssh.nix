{ pkgs, lib, config, ... }:

{
  programs.ssh = {

    enable = true;

    matchBlocks = {
      github = {
        hostname = "github.com";
        #TODO: a better way to reference this
        identityFile = [
          "/home/gideon/nix/configs/users/gideon/configs/ssh/keys/github-nixos-tester"
        ];
        #[ "/home/gideon/nix/user/configs/ssh/keys/github-nixos-tester" ];
        user = "git";
      };
      homeserver = {
        hostname = "66.108.176.86";
        #hostname = "${builtins.readFile config.age.secrets.ssh_athena_ip.path}";
        port = 2736;
        identityFile = [
          "/home/gideon/nix/configs/users/gideon/configs/ssh/keys/server-ssh"
        ];
        user = "overseer";
      };
    };
  };
}
