{ pkgs, lib, ... }:

{
  programs.ssh = {

    enable = true;

    matchBlocks = {
      github = {
        hostname = "github.com";
        #TODO: a better way to reference this
        identityFile =
          [ "/home/gideon/nix/configs/gideon/configs/ssh/keys/github-nixos-tester" ];
          #[ "/home/gideon/nix/user/configs/ssh/keys/github-nixos-tester" ];
        user = "git";
      };
    };
  };
}
