{ lib, inputs, config, ... }: 

{

  imports = [
    # Common Nod3 Message of the Day
    #./motd.nix    

    ./keepalived.nix
    ./k3s.nix

    ./charts/helm-dashboard/helm-dashboard.nix
    #./charts/kubeshark/kubeshark.nix
    #./charts/goldpinger/goldpinger.nix
    #./charts/kubernetes-dashboard/kubernetes-dashboard.nix
  ];

}
