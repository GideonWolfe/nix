{ pkgs, lib, config, ... }:

{

  programs.k9s = {

    enable = true;

    settings = {
      k9s = {
        refreshRate = 2;
        maxConnRetry = 5;
        enableMouse = true;
        headless = false;

        # Tell k9s where your kubeconfig is (can be omitted if using KUBECONFIG env)
        kubeConfig.path = "~/.kube/config"; # default

        # Explicitly name the context if your kubeconfig has one
        # (use `kubectl config get-contexts` to see the name)
        currentContext = "default";
      };
    };

  };

}
