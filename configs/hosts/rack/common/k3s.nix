{ lib, inputs, config, ... }: 

{

services.k3s = { 
  enable = true; 
  role = "server"; # all nodes are both server + agent 
  clusterInit = true; # safe to repeat everywhere per https://docs.k3s.io/datastore/ha-embedded 
  # TODO used for testing, eventually switch to tokenFile and SOPS secret
  token = "supersecret-token"; # must match on all nodes 
  
  extraFlags = [ 
    "--tls-san=192.168.0.50" # the shared keepalived virtual IP 
    #"--advertise-address=${config.networking.hostName}" # optional clarity 
  ];
};

# ensures the keepalived VIP exists before k3s starts 
systemd.services.k3s.after = [ "keepalived.service" ]; 
systemd.services.k3s.wants = [ "keepalived.service" ];

# environment.systemPackages = with pkgs; [ 
#   k9s 
# ];

}
