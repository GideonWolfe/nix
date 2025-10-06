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

}
