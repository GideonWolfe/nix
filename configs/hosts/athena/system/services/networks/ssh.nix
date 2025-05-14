{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 2736 ];
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  # TODO: optimize and generalize this setup
  users.users.overseer.openssh.authorizedKeys.keys = [
    "${builtins.readFile
    ../../../../../users/gideon/configs/ssh/gideon_ssh_sk.pub}"
  ];
}
