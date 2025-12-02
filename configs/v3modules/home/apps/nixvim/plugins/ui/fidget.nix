{
  #TODO: Rewrite fidget config with new opts since plugin got rewritten 
  programs.nixvim.plugins.fidget = {
    enable = true;
    # INFO: this was causing some startup delay
    settings.integration.nvim-tree.enable = false;
  };
}
