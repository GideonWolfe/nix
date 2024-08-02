{ pkgs, lib, config, ... }:

{

  # Home network:
  # router/gateway = 192.168.0.1
  # athena (homeserver) 
  ### 192.168.0.158 # enp17s0 (ethernet)
  ### 192.168.0.229 # wlp18s0 (wireless)

  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp17s0"; # Name of ethernet device
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      # postSetup = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      # '';
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.0.1/24 -o enp17s0 -j MASQUERADE
      '';

      # This undoes the above command
      # postShutdown = ''
      #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      # '';
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.0.1/24 -o enp17s0 -j MASQUERADE
      '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile =
        "/home/overseer/nix/configs/users/overseer/configs/ssh/keys/athena-wireguard";

      peers = [
        # List of allowed peers.
        { # Laptop
          publicKey =
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/HilHM8SQsBaqs45w2VcXsa6yWmt9Vqzg1bPaVU0u0 gideon@poseidon";
          allowedIPs = [ "10.100.0.2/32" ];
        }
      ];
    };
  };
}
