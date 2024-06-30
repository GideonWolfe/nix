{
  programs.nixvim.plugins.none-ls = {
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
