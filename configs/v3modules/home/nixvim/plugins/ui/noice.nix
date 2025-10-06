{
  programs.nixvim.plugins.noice = {

    enable = true;

    settings = {
      cmdline = {
        enabled = true;
        format = {
          cmdline = {
            #icon = ""; #TODO add icon when get templatized
            lang = "vim";
          };
        };
      };

      notify = {
        enabled = false; # handled by snacks;
      };

      popupmenu = {
        enabled = true;
        #backend = "cmp"; # should be nui if I can install it
        backend = "nui"; # should be nui if I can install it
      };

      lsp = {
        progress = {
          enabled = false; # handled by figdget
        };
        signature = {
          enabled = false; # handled by lsp-signature
        };
        hover = { enabled = true; };
      };

      presets = { lsp_doc_border = true; };

    };

  };
}
