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

    importUserKeys = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to automatically import the system user's SSH keys as authorized keys";
    };

    extraAuthorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional SSH public keys to authorize (beyond the system user's keys)";
    };

    # startAgent = lib.mkOption {
    #   type = lib.types.bool;
    #   default = false;
    #   description = "Whether to start SSH agent";
    # };
  };

  config = lib.mkIf cfg.enable {
    # Combine user SSH keys with additional keys
    users.users.${config.custom.user.name}.openssh.authorizedKeys.keys = 
      (lib.optionals cfg.importUserKeys config.custom.user.openssh.authorizedKeys) 
      ++ cfg.extraAuthorizedKeys;

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
