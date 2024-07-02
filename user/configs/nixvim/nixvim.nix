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
        ./plugins/ui/nvim-tree.nix
        ./plugins/ui/nvim-ufo.nix
        ./plugins/ui/rainbow-delimiters.nix
        ./plugins/ui/telescope.nix
        ./plugins/ui/trouble.nix
        ./plugins/ui/which-key.nix

        # Editing plugins
        ./plugins/editing/nvim-autopairs.nix
        ./plugins/editing/better-escape.nix
        ./plugins/editing/surround.nix
        ./plugins/editing/comment.nix
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

    ];
	programs.nixvim = {

		# Enable NixVim configuration
		enable = true;

        enableMan = true;

        globals = {
            mapleader = " ";
        };

        clipboard.providers = {
            wl-copy = {
                enable = true;
            };
        };
        clipboard.register = "unnamedplus";

        # autoCmd = [
        #     # resumes last place in file
        #     {
        #         event = "BufReadPost";
        #         callback = {
        #             __raw = ''
        #                 function()
        #                     vim.cmd([[
        #                         if line("'\"") > 0 && line("'\"") <= line("$") |
        #                             exe "normal! g`\"" |
        #                         endif
        #                     ]])
        #                 end
        #             '';
        #         };
        #
        #     }
        # ];




        # adding plugins that don't have a module yet
        extraPlugins = with pkgs.vimPlugins; [
            lazygit-nvim
        ];

	};
}
