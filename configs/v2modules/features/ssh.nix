{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.custom.features.ssh;
in {
  options.custom.features.ssh = {
    enable = lib.mkEnableOption "SSH server support";

    ports = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [ 2736 ];
      description = "List of ports for SSH server to listen on";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to open SSH ports in the firewall";
    };

    permitRootLogin = lib.mkOption {
      type = lib.types.enum [ "yes" "no" "prohibit-password" "forced-commands-only" ];
      default = "no";
      description = "Whether to allow root login via SSH";
    };

    passwordAuthentication = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to allow password authentication";
    };

    # startAgent = lib.mkOption {
    #   type = lib.types.bool;
    #   default = false;
    #   description = "Whether to start SSH agent";
    # };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = cfg.ports;
      openFirewall = cfg.openFirewall;
      settings = {
        PermitRootLogin = cfg.permitRootLogin;
        PasswordAuthentication = cfg.passwordAuthentication;
      };
    };

    #programs.ssh.startAgent = lib.mkIf cfg.startAgent true;
  };
}
