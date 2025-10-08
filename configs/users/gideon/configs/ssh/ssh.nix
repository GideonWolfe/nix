{ pkgs, lib, config, ... }:

{
  programs.ssh = {

    enable = true;

    #addKeysToAgent = "yes";
    # Should prevent being prompted for yubikey every 5 seconds with nixos-anywhere
    controlMaster = "auto";
    controlPersist = "10m";
    controlPath = "~/.ssh/cm_socket_%r@%h:%p";

    matchBlocks = {
      github = {
        hostname = "github.com";
        #TODO: a better way to reference this
        identityFile = [
          "${config.home.homeDirectory}/.ssh/gideon_ssh_sk"
          "/home/gideon/nix/configs/users/gideon/configs/ssh/keys/github-nixos-tester"
        ];
        #[ "/home/gideon/nix/user/configs/ssh/keys/github-nixos-tester" ];
        user = "git";
      };
      homeserver = {
        hostname = "66.108.176.86";
        port = 2736;
        identityFile = [ "${config.home.homeDirectory}/.ssh/gideon_ssh_sk" ];
        user = "overseer";
      };
      alpha = {
        hostname = "192.168.0.163";
        port = 2736;
        identityFile = [ "${config.home.homeDirectory}/.ssh/gideon_ssh_sk" ];
        user = "gideon";
      };
      beta = {
        hostname = "192.168.0.116";
        port = 2736;
        identityFile = [ "${config.home.homeDirectory}/.ssh/gideon_ssh_sk" ];
        user = "gideon";
      };
      laptoptest = {
        hostname = "192.168.0.77";
        #port = 2736;
        identityFile = [
          #"/home/gideon/nix/configs/users/gideon/configs/ssh/keys/server-ssh"
          "${config.home.homeDirectory}/.ssh/gideon_ssh_sk"
        ];
        #user = "gideon";
        forwardAgent = true;
        extraOptions = {
          #IdentityAgent = "${ builtins.getEnv "XDG_RUNTIME_DIR" }/yubikey-agent/yubikey-agent.sock";
          IdentityAgent = "/run/user/1000/yubikey-agent/yubikey-agent.sock";
        };
      };
    };
  };

  # handle symlinking my public key to the SSH folder
  home.file.gideon_ssh_sk_pub = {
    enable = true;
    source = ./gideon_ssh_sk.pub;
    target = "${config.home.homeDirectory}/.ssh/gideon_ssh_sk.pub";
  };
}
