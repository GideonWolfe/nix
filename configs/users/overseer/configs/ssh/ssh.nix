{ pkgs, lib, ... }:

{
  programs.ssh = {

    enable = true;

    matchBlocks = {
      github = {
        hostname = "github.com";
        #TODO: a better way to reference this
        identityFile =
          [ "/home/overseer/nix/configs/users/overseer/configs/ssh/keys/github-nixos-tester" ];
        user = "git";
      };
    };
  };
}
