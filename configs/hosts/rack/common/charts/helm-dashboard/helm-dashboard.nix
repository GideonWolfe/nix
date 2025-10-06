{ lib, inputs, config, ... }: 

{
  services.k3s.autoDeployCharts.helm-dashboard = { 
    name = "helm-dashboard";
    enable = true; 
    repo = "https://helm-charts.komodor.io";
    #https://github.com/komodorio/helm-charts/releases/tag/helm-dashboard-2.0.4
    version = "2.0.4";
    hash = "sha256-zheLILv2ONZw2LBPCdz85tUFbiqntjfaCroxi3igNcU=";
    # this is defualt but maybe change later
    targetNamespace = "default";
    #createNamespace = true; # might be useful once we have custom NS

    values = {
      ingress = {
        enabled = true;
        className = "traefik";
        hosts = [
          {
            host = "helm-dashboard.local";
            paths = [
              {
                path = "/";
                pathType = "Prefix";
              }
            ];
          }
        ];
      };
    };

  };
}
