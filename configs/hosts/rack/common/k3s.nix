{ lib, inputs, config, ... }: 

{

services.k3s = { 
  enable = true; 
  role = "server"; # all nodes are both server + agent 
  # Default to NOT initializing cluster - hosts can override
  clusterInit = lib.mkDefault false;
  # Default serverAddr - hosts can override or disable
  serverAddr = lib.mkDefault "https://192.168.0.163:6443"; # alpha's direct IP
  # Shared token for all nodes
  token = "supersecret-token"; # must match on all nodes 
  
  extraFlags = [ 
    "--tls-san=192.168.0.50" # the shared keepalived virtual IP 
    "--tls-san=192.168.0.163" # alpha's direct IP
    "--tls-san=192.168.0.116" # beta's direct IP 
  ];
};

# Open firewall ports for k3s cluster communication
networking.firewall = {
  allowedTCPPorts = [
    6443  # k3s API server
    2379  # etcd clients
    2380  # etcd peers
    10250 # kubelet API
    10251 # kube-scheduler
    10252 # kube-controller-manager
    10256 # kube-proxy health check
  ];
  allowedUDPPorts = [
    8472  # flannel VXLAN
  ];
  # Allow k3s traffic from cluster subnet
  allowedTCPPortRanges = [
    { from = 30000; to = 32767; } # NodePort services
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