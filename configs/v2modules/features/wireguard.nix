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
      # Client IP and subnet (auto-derived from world config)
      ips = [ "${config.custom.world.hosts.wireguard.clients.${config.networking.hostName}.vpnIp}/24" ];
      
      # Listen on the same port as configured in world
      listenPort = config.custom.world.hosts.wireguard.port;

      # Always generate private key automatically
      generatePrivateKeyFile = true;
      privateKeyFile = "/root/wireguard/${config.networking.hostName}-${cfg.interfaceName}-private.key";

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

    # Helper service to display public key for server configuration
    systemd.services.wireguard-pubkey-display = {
      description = "Display WireGuard public key for server configuration";
      after = [ "wireguard-${cfg.interfaceName}.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        echo "============================================="
        echo "WireGuard Public Key for ${config.networking.hostName}"
        echo "============================================="
        echo "Public Key: $(${pkgs.wireguard-tools}/bin/wg show ${cfg.interfaceName} public-key)"
        echo "VPN IP: ${config.custom.world.hosts.wireguard.clients.${config.networking.hostName}.vpnIp}/24"
        echo ""
        echo "Update world.nix:"
        echo "============================================="
        echo ""
        echo "custom.world.hosts.wireguard.clients.${config.networking.hostName}.publicKey = \"$(${pkgs.wireguard-tools}/bin/wg show ${cfg.interfaceName} public-key)\";"
        echo "============================================="
      '';
    };
  };
}
