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
    # ./plugins/ui/dashboard.nix
    # ./plugins/ui/fidget.nix
    ./plugins/ui/helpview.nix
    ./plugins/ui/indent-blankline.nix
    ./plugins/ui/lspkind.nix
    ./plugins/ui/lualine.nix
    ./plugins/ui/noice.nix
    ./plugins/ui/colorizer.nix # this has a high startuptime
    ./plugins/ui/nvim-tree.nix
    ./plugins/ui/nvim-ufo.nix
    ./plugins/ui/rainbow-delimiters.nix
    ./plugins/ui/web-devicons.nix
    ./plugins/ui/statuscol.nix
    ./plugins/ui/telescope.nix
    ./plugins/ui/trouble.nix
    ./plugins/ui/which-key.nix
    ./plugins/ui/smear-cursor.nix

    # Editing plugins
    ./plugins/editing/nvim-autopairs.nix
    #./plugins/editing/better-escape.nix
    ./plugins/editing/comment.nix
    # #TODO: surround and sandwich may do the same thing
    ./plugins/editing/surround.nix
    # #./plugins/editing/sandwich.nix
    ./plugins/editing/cmp.nix
    #./plugins/editing/blink-cmp.nix
    ./plugins/editing/lsp-format.nix

    # Version Control Plugins
    ./plugins/git/gitsigns.nix
    ./plugins/git/fugitive.nix
    ./plugins/git/diffview.nix

    # Utils
    # ./plugins/utils/dap.nix
    ./plugins/utils/friendly-snippets.nix
    ./plugins/utils/hop.nix
    ./plugins/utils/lspsaga.nix
    ./plugins/utils/luasnip.nix
    # ./plugins/utils/markdown-preview.nix
    # ./plugins/utils/markdown-preview-css.nix
    ./plugins/utils/none-ls.nix
    # ./plugins/utils/project-nvim.nix
    #./plugins/utils/treesitter.nix # BUG: raises startup time
    ./plugins/utils/todo-comments.nix
    ./plugins/utils/vimtex.nix
    ./plugins/utils/snacks.nix
    # ./plugins/utils/hmts.nix
    # ./plugins/utils/image.nix

    # Development plugins for specific frameworks/langs
    #./plugins/dev/godot.nix

  ];
  programs.nixvim = {

    # Enable NixVim configuration
    enable = true;

    enableMan = true;

    globals = { mapleader = " "; };

    clipboard.providers = { wl-copy = { enable = true; }; };
    clipboard.register = "unnamedplus";

    #HACK: adding plugins that don't have a module yet
    extraPlugins = with pkgs.vimPlugins; [
      lazygit-nvim
      lsp_signature-nvim
      yuck-vim
    ];

    extraConfigLuaPre = ''

      -- Define breakpoint symbol
      --vim.fn.sign_define('DapBreakpoint', {text="•", texthl="BreakpointLineNr", linehl="", numhl="BreakpointLineNr"})


      -- Setup profiler
      if vim.env.PROF then
          local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
          vim.opt.rtp:append(snacks)
          require("snacks.profiler").startup({
            startup = {
              event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
          },
        })
      end
    '';

    # Performance tweaks
    performance.byteCompileLua.enable = true;
    #performance.byteCompileLua.configs = true;
    #performance.byteCompileLua.initLua = true;
    #performance.byteCompileLua.nvimRuntime = true;
    #performance.byteCompileLua.plugins = true;
    #performance.combinePlugins.enable = true;

    diagnostic.settings = {
      signs = {
        text = {
          "[vim.diagnostic.severity.ERROR]" = "󰅚 ";
          "[vim.diagnostic.severity.WARN]" = "󰀪 ";
          "[vim.diagnostic.severity.INFO]" = " ";
          "[vim.diagnostic.severity.HINT]" = "󰌶 ";
        };
      };
    };

  };
}
