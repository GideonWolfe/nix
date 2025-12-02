{ pkgs, lib, config, ... }:

# General Kubernetes Stuff
{

  programs.kubecolor = {
    enable = true;
    enableAlias = true;
  };

  home.sessionVariables = {
    # Make sure kubectl and k9s know where to find the user readable kubeconfig
    KUBECONFIG="${config.home.homeDirectory}/.kube/config";
  };

  programs.k9s = {

    enable = true;

    settings = {
      k9s = {
        #refreshRate = 2;
        #maxConnRetry = 5;
        #enableMouse = true;
        #headless = false;

        # Tell k9s where your kubeconfig is (can be omitted if using KUBECONFIG env)
        kubeConfig.path = "~/.kube/config"; # default
      };
      
      # Explicitly name the context if your kubeconfig has one
      # (use `kubectl config get-contexts` to see the name)
      currentContext = "default";
    };

  };
}
