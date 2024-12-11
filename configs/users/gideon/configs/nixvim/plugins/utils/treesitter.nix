{
  # Main Treesitter plugin
  programs.nixvim.plugins.treesitter = {
    enable = true;
    #ensureInstalled = "all";
    folding = false;
    #indent.enable = true;
    settings = {
      ensure_installed = "all";
      indent.enable = true;
    };
  };
  # Text Objects
  programs.nixvim.plugins.treesitter-textobjects = { enable = true; };
  # Top of screen shows what your current context is
  programs.nixvim.plugins.treesitter-context = { enable = false; };
}
