{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.wireguard = {
    image = "linuxserver/wireguard:latest";
    ports = [ "51820:51820/udp" ];
    autoStart = true;
    environment = {
      PUID = "1000";
      PGID = "100";
      PEERS = "gideon-pixel8,gideon-poseidon";
      #PEERDNS = "1.1.1.2,1.0.0.2"; # DNS servers (these are cloudflare)
      PEERDNS = "auto"; # DNS servers (these are cloudflare)
      #SERVERPORT = "12345";
    };
    volumes =
      [ "/pool/data/services/networking/wireguard/data:/var/www/html/storage" ];
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--cap-add=SYS_MODULE"
      "--sysctl='net.ipv4.conf.all.src_valid_mark=1'"
    ];
  };

}
