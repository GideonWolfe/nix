{ pkgs, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

  imports = [
    # Core
    ./core/opts.nix
    ./core/lsp.nix
    ./core/highlight.nix
    ./core/keymaps.nix
    ./core/autocommands.nix

    # Plugins

    # UI Plugins
    ./plugins/ui/bufferline.nix
    ./plugins/ui/dashboard.nix
    ./plugins/ui/fidget.nix
    ./plugins/ui/indent-blankline.nix
    ./plugins/ui/lspkind.nix
    ./plugins/ui/lualine.nix
    ./plugins/ui/noice.nix
    ./plugins/ui/nvim-colorizer.nix
    ./plugins/ui/nvim-tree.nix
    ./plugins/ui/nvim-ufo.nix
    ./plugins/ui/rainbow-delimiters.nix
    ./plugins/ui/telescope.nix
    ./plugins/ui/trouble.nix
    ./plugins/ui/which-key.nix

    # Editing plugins
    ./plugins/editing/nvim-autopairs.nix
    ./plugins/editing/better-escape.nix
    ./plugins/editing/comment.nix
    #TODO: surround and sandwich may do the same thing
    ./plugins/editing/surround.nix
    #./plugins/editing/sandwich.nix
    ./plugins/editing/cmp.nix
    ./plugins/editing/lsp-format.nix

    # Version Control Plugins
    ./plugins/git/gitsigns.nix
    ./plugins/git/fugitive.nix
    ./plugins/git/diffview.nix

    # Utils
    ./plugins/utils/dap.nix
    ./plugins/utils/friendly-snippets.nix
    ./plugins/utils/hop.nix
    ./plugins/utils/lspsaga.nix
    ./plugins/utils/luasnip.nix
    ./plugins/utils/markdown-preview.nix
    ./plugins/utils/none-ls.nix
    ./plugins/utils/project-nvim.nix
    ./plugins/utils/treesitter.nix
    ./plugins/utils/todo-comments.nix
    ./plugins/utils/vimtex.nix

    # Development plugins for specific frameworks/langs
    ./plugins/dev/godot.nix

  ];
  programs.nixvim = {

    # Enable NixVim configuration
    enable = true;

    enableMan = true;

    globals = { mapleader = " "; };

    clipboard.providers = { wl-copy = { enable = true; }; };
    clipboard.register = "unnamedplus";

    #HACK: adding plugins that don't have a module yet
    extraPlugins = with pkgs.vimPlugins; [ lazygit-nvim lsp_signature-nvim ];

    #HACK: Running these sign define commands as raw lua because nixvim doesn't have a setting
    extraConfigLuaPre = ''
      -- Define Diagnostic Signs
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';

  };
}
