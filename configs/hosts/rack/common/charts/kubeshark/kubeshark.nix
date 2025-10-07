{ lib, inputs, config, ... }: 

{
  services.k3s.autoDeployCharts.kubeshark = { 
    name = "kubeshark";
    enable = true; 
    repo = "https://helm.kubeshark.co";
    version = "52.9.0";
    hash = "sha256-+z7woDT4LAGzGATffwTXPRyHb4eZKwMEv3Hj62knyOg=";
    # this is defualt but maybe change later
    targetNamespace = "default";
    #createNamespace = true; # might be useful once we have custom NS

    #https://github.com/kubeshark/kubeshark/blob/master/helm-chart/values.yaml
    values = {
      tap = {
        ingress = {
          enabled = true;
          className = "traefik";
          host = "kubeshark.local";
        };
        telemetry.enabled = false;
        auth.enabled = false;
      };
      cloudLicenseEnabled = false;
    };

  };
}
