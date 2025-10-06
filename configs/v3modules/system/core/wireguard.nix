{ config, lib, pkgs, inputs, ... }:

let cfg = config.custom.features.wireguard;
in {
  options.custom.features.wireguard = {
    enable = lib.mkEnableOption "WireGuard VPN client support";
  };

  config = lib.mkIf cfg.enable {
    # Open firewall for WireGuard
    networking.firewall.allowedUDPPorts = [
      config.custom.world.hosts.wireguard.port
    ];

    # Configure WireGuard interface
    networking.wireguard.interfaces.wg0 = {
      # Client IP and subnet (auto-derived from world config)
      ips = [ "${config.custom.world.hosts.wireguard.clients.${config.networking.hostName}.vpnIp}/24" ];
      
      # Listen on the same port as configured in world
      listenPort = config.custom.world.hosts.wireguard.port;

      # Always generate private key automatically
      generatePrivateKeyFile = true;
      privateKeyFile = "/root/wireguard/${config.networking.hostName}-wg0-private.key";

      # Server peer configuration
      peers = [{
        # Server public key from world config
        publicKey = config.custom.world.hosts.wireguard.publicKey;

        # Route only server traffic through VPN
        allowedIPs = [ config.custom.world.hosts.wireguard.vpnServerIp ];

        # Server endpoint constructed from IP and port
        endpoint = "${config.custom.world.hosts.wireguard.serverIp}:${toString config.custom.world.hosts.wireguard.port}";

        # Keep NAT tables alive
        persistentKeepalive = 25;
      }];
    };

    # Helper service to display public key for server configuration
    systemd.services.wireguard-pubkey-display = {
      description = "Display WireGuard public key for server configuration";
      after = [ "wireguard-wg0.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        echo "============================================="
        echo "WireGuard Public Key for ${config.networking.hostName}"
        echo "============================================="
        echo "Public Key: $(${pkgs.wireguard-tools}/bin/wg show wg0 public-key)"
        echo "VPN IP: ${config.custom.world.hosts.wireguard.clients.${config.networking.hostName}.vpnIp}/24"
        echo ""
        echo "Update world.nix:"
        echo "============================================="
        echo ""
        echo "custom.world.hosts.wireguard.clients.${config.networking.hostName}.publicKey = \"$(${pkgs.wireguard-tools}/bin/wg show wg0 public-key)\";"
        echo "============================================="
      '';
    };
  };
}
