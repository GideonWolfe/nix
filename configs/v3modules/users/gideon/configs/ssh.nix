{ pkgs, lib, config, osConfig, ... }:

{
  programs.ssh = {

    enable = true;

    #addKeysToAgent = "yes";
    # Should prevent being prompted for yubikey every 5 seconds with nixos-anywhere

    matchBlocks = {
      github = {
        hostname = "github.com";
        identityFile = [
          "${config.home.homeDirectory}/.ssh/gideon_ssh_sk"
        ];
        user = "git";
        controlPath = "~/.ssh/cm_socket_%r@%h:%p";
        controlMaster = "auto";
        controlPersist = "10m";
      };
      homeserver = {
        hostname = "66.108.176.86";
        port = 2736;
        identityFile = [ "${config.home.homeDirectory}/.ssh/gideon_ssh_sk" ];
        user = "overseer";
        controlPath = "~/.ssh/cm_socket_%r@%h:%p";
        controlMaster = "auto";
        controlPersist = "10m";
      };
      # monitoring = {
      #   hostname = "${osConfig.custom.world.hosts.monitor.ip}";
      #   port = 2736;
      #   identityFile = [ "${config.home.homeDirectory}/.ssh/gideon_ssh_sk" ];
      #   user = "gideon";
      # };
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
        controlPath = "~/.ssh/cm_socket_%r@%h:%p";
        controlMaster = "auto";
        controlPersist = "10m";
      };
    };
  };

  # handle symlinking my public key to the SSH folder
  home.file.gideon_ssh_sk_pub = {
    enable = true;
    source = ../keys/gideon_ssh_sk.pub;
    target = "${config.home.homeDirectory}/.ssh/gideon_ssh_sk.pub";
  };
}
