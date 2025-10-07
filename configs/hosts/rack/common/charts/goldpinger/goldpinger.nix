{ lib, inputs, config, ... }: 

{
  services.k3s.autoDeployCharts.goldpinger = { 
    name = "goldpinger";
    enable = true; 
    repo = "https://bloomberg.github.io/goldpinger";
    #https://github.com/bloomberg/goldpinger/blob/master/charts/goldpinger/Chart.yaml
    # version from chart needs to be set instead of App version in Releases
    version = "1.0.1";
    hash = "sha256-piAAQ9U0d4KwNKgxMqOiu9AtM+KgenAwmttYXWmwe5o=";
    # this is defualt but maybe change later
    targetNamespace = "default";
    #createNamespace = true; # might be useful once we have custom NS

    #https://github.com/bloomberg/goldpinger/blob/master/charts/goldpinger/values.yaml
    values = {
      ingress = {
        enabled = true;
        className = "traefik";
        hosts = [
          {
            host = "goldpinger.local";
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
