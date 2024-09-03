{ pkgs, lib, config, ... }:

{

  # Home network:
  # router/gateway = 192.168.0.1
  # athena (homeserver) 
  ### 192.168.0.158 # enp17s0 (ethernet)

  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp17s0"; # Name of ethernet device
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = { allowedUDPPorts = [ 123 ]; };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      #listenPort = 51820;
      listenPort = 123;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o enp17s0 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o enp17s0 -j MASQUERADE
      '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/root/wireguard/athena-wireguard";

      peers = [
        # List of allowed peers.
        { # Laptop
          publicKey = "Ls+l1TbBvthQ/jVPTXtKrxuaca+yehG6A+cHHrx290s=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
        { # Pixel8
          # Keypair generated in Android app
          publicKey = "qgtU/gzNYCHI9bnn2RqMZHcyOe3AFmGUU69wgrcNfzA=";
          allowedIPs = [ "10.100.0.3/32" ];
        }
      ];
    };
  };
}
