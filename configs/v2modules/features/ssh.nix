{ config, lib, pkgs, ... }:

let cfg = config.custom.features.ssh;
in {
  options.custom.features.ssh = {
    enable = lib.mkEnableOption "SSH server";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 2736 ];
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
  };
}
