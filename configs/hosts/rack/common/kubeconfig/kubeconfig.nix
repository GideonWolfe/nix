{ config, ... }: {
  sops.secrets."kubeconfig" = {
      sopsFile = ./kubeconfig.yaml;
      path = "/etc/rancher/k3s/k3s.yaml";
      #owner = "kube";
  };
}
