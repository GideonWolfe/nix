{ lib, inputs, config, ... }: 

{

services.k3s = { 
  enable = true; 
  role = "server"; # all nodes are both server + agent 
  clusterInit = true; # safe to repeat everywhere per https://docs.k3s.io/datastore/ha-embedded 
  # Only try to join if cluster exists, otherwise bootstrap
  # Use https for the Kubernetes API (k3s handles TLS internally)
  serverAddr = lib.mkDefault "https://192.168.0.50:6443";
  # TODO used for testing, eventually switch to tokenFile and SOPS secret
  token = "supersecret-token"; # must match on all nodes 
  
  extraFlags = [ 
    "--tls-san=192.168.0.50" # the shared keepalived virtual IP 
    "--cluster-cidr=10.42.0.0/16" # force IPv4 cluster CIDR
    "--service-cidr=10.43.0.0/16" # force IPv4 service CIDR
  ];
};

# ensures the keepalived VIP exists before k3s starts
systemd.services.k3s = {
  after = [ "keepalived.service" ];
  wants = [ "keepalived.service" ];
};

# Strategy: Let k3s generate its own kubeconfig at /etc/rancher/k3s/k3s.yaml
# Then use a systemd service to copy it to user's ~/.kube/config when it changes
systemd.tmpfiles.rules = [
  "d /home/gideon/.kube 0700 gideon users - -"
];

# Service to copy k3s-generated kubeconfig to user directory
systemd.services.sync-kubeconfig = {
  description = "Sync k3s kubeconfig to user directory";
  after = [ "k3s.service" ];
  wants = [ "k3s.service" ];
  serviceConfig = {
    Type = "oneshot";
    RemainAfterExit = true;
    ExecStart = "/bin/sh -c 'if [ -f /etc/rancher/k3s/k3s.yaml ]; then cp /etc/rancher/k3s/k3s.yaml /home/gideon/.kube/config && chown gideon:users /home/gideon/.kube/config && chmod 600 /home/gideon/.kube/config; fi'";
  };
  wantedBy = [ "multi-user.target" ];
};

# Timer to periodically sync kubeconfig (in case it gets updated)
systemd.timers.sync-kubeconfig = {
  description = "Periodically sync k3s kubeconfig";
  timerConfig = {
    OnBootSec = "1m";
    OnUnitActiveSec = "5m";
    Unit = "sync-kubeconfig.service";
  };
  wantedBy = [ "timers.target" ];
};

# environment.systemPackages = with pkgs; [ 
#   k9s 
# ];

}
