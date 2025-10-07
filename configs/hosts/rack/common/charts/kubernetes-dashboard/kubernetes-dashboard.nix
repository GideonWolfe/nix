{ lib, inputs, config, ... }: 

{
  services.k3s.autoDeployCharts.kubernetes-dashboard = { 
    name = "kubernetes-dashboard";
    enable = true; 
    repo = "https://kubernetes.github.io/dashboard/";
    version = "7.13.0";
    hash = "sha256-/3vJZF3pAe1Jo0LGPnXqQQ7bwr3n4wR6kgfuckxvAeQ=";
    # this is defualt but maybe change later
    targetNamespace = "default";
    #createNamespace = true; # might be useful once we have custom NS

    #https://github.com/kubernetes/dashboard/blob/master/charts/kubernetes-dashboard/values.yaml
    values = {
      app = {
        ingress = {
          enabled = true;
          ingressClassName = "traefik";
          hosts = [
            "kube-dashboard.local"
          ];
        };
      };
    };
  };
}
