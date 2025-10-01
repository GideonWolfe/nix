{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let cfg = config.custom.features.wireguard;
in {
  options.custom.features.wireguard = {
    enable = lib.mkEnableOption "WireGuard VPN client support";

    interfaceName = lib.mkOption {
      type = lib.types.str;
      default = "wg0";
      description = "Name of the WireGuard interface";
    };

    clientIp = lib.mkOption {
      type = lib.types.str;
      description = "Client IP address in the VPN network (e.g., 10.100.0.4/24)";
    };

    persistentKeepalive = lib.mkOption {
      type = lib.types.int;
      default = 25;
      description = "Send keepalives every N seconds to keep NAT tables alive";
    };

    allowedIPs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of allowed IPs to route through VPN (empty list uses server IP only)";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to open the WireGuard port in the firewall";
    };
  };

  config = lib.mkIf cfg.enable {
    # Open firewall for WireGuard
    networking.firewall.allowedUDPPorts = lib.mkIf cfg.openFirewall [
      config.custom.world.hosts.wireguard.port
    ];

    # Configure WireGuard interface
    networking.wireguard.interfaces.${cfg.interfaceName} = {
      # Client IP and subnet
      ips = [ cfg.clientIp ];
      
      # Listen on the same port as configured in world
      listenPort = config.custom.world.hosts.wireguard.port;

      # Always generate private key automatically
      generatePrivateKeyFile = true;

      # Server peer configuration
      peers = [{
        # Server public key from world config
        publicKey = config.custom.world.hosts.wireguard.publicKey;

        # Allowed IPs - default to server IP only, or use custom list
        allowedIPs = if cfg.allowedIPs == [] 
          then [ config.custom.world.hosts.wireguard.vpnServerIp ]
          else cfg.allowedIPs;

        # Server endpoint constructed from IP and port
        endpoint = "${config.custom.world.hosts.wireguard.serverIp}:${toString config.custom.world.hosts.wireguard.port}";

        # Keepalive settings
        persistentKeepalive = cfg.persistentKeepalive;
      }];
    };
  };
}
