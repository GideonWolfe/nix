{
  programs.nixvim.plugins.indent-blankline = {
        enable = true;
        settings = {

            indent = {
                char = "▏";
            };

            exclude = {
                filetypes = [
                    "help"
                    "defx"
                    "vimwiki"
                    "man"
                    "gitmessengerpopup"
                    "gitcommit"
                    "diagnosticpopup"
                    "lspinfo"
                    "packer"
                    "text"
                    "markdown"
                    "yaml"
                    "dashboard"
                    "TelescopePrompt"
                    "NvimTree"
                    ""
                ];
                buftypes = [
                    "terminal"
                    "nofile"
                ];
            };
        };
    };
}
