{ lib, inputs, config, ... }: 

{

  imports = [
    ./keepalived.nix
    ./k3s.nix

    # secret definition for the shared kubeconfig
    ./kubeconfig/kubeconfig.nix

    ./charts/helm-dashboard/helm-dashboard.nix
    ./charts/kubeshark/kubeshark.nix
    ./charts/goldpinger/goldpinger.nix
    ./charts/kubernetes-dashboard/kubernetes-dashboard.nix
  ];

}
