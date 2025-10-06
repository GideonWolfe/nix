{
  programs.nixvim.plugins.image = {
    # INFO: this was a startup hog, lazyload?
    enable = false;
    settings.backend = "kitty";
  };
}
