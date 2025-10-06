{
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      formatting = {
        stylua.enable = true;
        nixfmt.enable = true;
      };
      diagnostics = {
        deadnix.enable = true;
        #eslint.enable = true;
      };
    };
  };
}
