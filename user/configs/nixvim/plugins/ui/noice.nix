{
  programs.nixvim.plugins.noice = {
      
    enable = true;

    presets = {
        lsp_doc_border = true;
    };

    lsp = {
        progress = {
            enabled = false; # handled by figdget
        };
        signature = {
            enabled = false; # handled by lsp-signature
        };
        hover = {
            enabled = true;
        };
    };

    cmdline = {
        enabled = true;
        format = {
            cmdline = {
                #icon = ""; #TODO add icon when get templatized
                lang = "vim";
            };
        };
    };

    popupmenu = {
        enabled = true;
        #backend = "cmp"; # should be nui if I can install it
        backend = "nui"; # should be nui if I can install it
    };
  };
}
