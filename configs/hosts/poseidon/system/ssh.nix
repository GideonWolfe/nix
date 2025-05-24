{ config, lib, pkgs, ... }:

{
  # Enable OpenSSH
  services.openssh.enable = true;
  # OpenSSH Settings
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };

  # TODO: optimize and generalize this setup
  users.users.gideon.openssh.authorizedKeys.keys = [
    "${builtins.readFile ../../../users/gideon/configs/ssh/gideon_ssh_sk.pub}"
  ];
}
