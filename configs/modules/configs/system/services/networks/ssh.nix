{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [2736];
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
}
