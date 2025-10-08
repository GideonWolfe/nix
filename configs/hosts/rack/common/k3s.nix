{ lib, inputs, config, ... }: 

{

services.k3s = { 
  enable = true; 
  role = "server"; # all nodes are both server + agent 
  clusterInit = true; # safe to repeat everywhere per https://docs.k3s.io/datastore/ha-embedded 
  # Only try to join if cluster exists, otherwise bootstrap
  serverAddr = lib.mkDefault "https://192.168.0.50:6443";
  # TODO used for testing, eventually switch to tokenFile and SOPS secret
  token = "supersecret-token"; # must match on all nodes 
  
  extraFlags = [ 
    "--tls-san=192.168.0.50" # the shared keepalived virtual IP 
  ];
};

# ensures the keepalived VIP exists before k3s starts 
# and waits for SOPS to place the secret
systemd.services.k3s = {
  after = [ "keepalived.service" "sops-nix.service" ];
  wants = [ "keepalived.service" ];
  preStart = ''
    # Make the SOPS-placed config read-only so k3s can't overwrite it
    if [ -f /etc/rancher/k3s/k3s.yaml ]; then
      chmod 444 /etc/rancher/k3s/k3s.yaml
    fi
  '';
};

# Strategy: Let SOPS place the kubeconfig at /etc/rancher/k3s/k3s.yaml
# Then copy that to user's ~/.kube/config
systemd.tmpfiles.rules = [
  "d /etc/rancher/k3s 0755 root root - -"
  "d /home/gideon/.kube 0700 gideon users - -"
  # Copy the SOPS-managed config to user directory
  "C /home/gideon/.kube/config 0600 gideon users - /etc/rancher/k3s/k3s.yaml"
];

# environment.systemPackages = with pkgs; [ 
#   k9s 
# ];

}
