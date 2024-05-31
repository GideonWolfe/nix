{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.nixvim = {

		# Enable NixVim configuration
		enable = true;

        enableMan = true;

        globals = {
            mapleader = " ";
        };

		# Basic Neovim options
		opts = {
			# General options

			# Enable mouse
			mouse = "a";

			# Disable swap
			swapfile = false;
			# Enable undofile
			undofile = true;

			# Autocomplete options
			completeopt = "menuone,noinsert,noselect";

			# Highlight search results
			hlsearch = true;
			incsearch = true;
			ignorecase = true;
			smartcase = true;


			# wait time for key sequences
			timeoutlen = 500;
			# faster completion
			updatetime = 300;


			# Enable spellcheck
			spell = true;

			list = false;

			# Set line numbers
			number = true;
			relativenumber = true;
			numberwidth = 2;

			signcolumn = "yes";
			
			# Show matching parens
			showmatch = true;

			foldmethod = "marker";


			# splits
			splitright = true;
			splitbelow = true;

			linebreak = true;
			wrap = true;

			laststatus = 3;
			cmdheight = 2;

			showmode = false;

			scrolloff = 3;
			sidescrolloff = 5;

			conceallevel = 0;

			cursorline = true;

			pumheight = 10;

			showtabline = 2;

			# Tabs and indents
			# use spaces instead of tabs
			expandtab = true;
			# shift 4 spaces when tabbed
			tabstop = 4;
			shiftwidth = 4;
			# autoindent new lines
			smartindent = true;

			# memory and cpu
			# enable background buffers
			hidden = true;
			# remember N lines in history
			history = 100;

			fillchars = {
				fold = "─";
				diff = "╱";
				wbr = "─";
				msgsep = "─";
				horiz = "─";
				horizup = "│";
				horizdown = "│";
				vertright = "│";
				vertleft = "│";
				verthoriz = "│";
			};

		};




        # adding plugins that don't have a module yet
        extraPlugins = with pkgs.vimPlugins; [
            lazygit-nvim
            hop-nvim
        ];

        plugins = {

            lsp = {
                # Enable LSPs to be configured
                enable = true;

                # Configs for all LSP servers
                servers = {
                    # Nix 
                    nil_ls = {
                        # enable nil LSP for Nix
                        enable = true;
                    };

                    # Bash
                    bashls = {
                        enable = true;
                    };

                    # Clojure
                    clojure-lsp = {
                        enable = true;
                    };

                    # Cmake
                    cmake = {
                        enable = true;
                    };

                    # C#
                    csharp-ls = {
                        enable = true;
                    };

                    # CSS
                    cssls = {
                        enable = true;
                    };

                    # JS
                    eslint = {
                        enable = true;
                    };

                    # Godot Script
                    gdscript = {
                        enable = true;
                    };

                    # Go
                    gopls = {
                        enable = true;
                    };

                    # Haskell
                    hls = {
                        enable = true;
                    };

                    # html
                    html = {
                        enable = true;
                    };

                    # JSON
                    jsonls = {
                        enable = true;
                    };

                    # Julia
                    julials = {
                        enable = true;
                    };

                    # Kotlin
                    kotlin-language-server = {
                        enable = true;
                    };

                    # Lua
                    lua-ls = {
                        enable = true;
                    };

                    # PHP
                    phpactor = {
                        enable = true;
                    };

                    # Python
                    pyright = {
                        enable = true;
                    };

                    # Rust
                    rust-analyzer = {
                        enable = true;
                        # automatically install deps if not already
                        installCargo = true;
                        installRustc = true;
                    };

                    # Tailwind CSS
                    tailwindcss = {
                        enable = true;
                    };

                    # LaTeX
                    texlab = {
                        enable = true;
                    };

                    # Typescript
                    tsserver = {
                        enable = true;
                    };

                    # Vue JS
                    vuels = {
                        enable = true;
                    };

                    # YAML
                    yamlls = {
                        enable = true;
                    };

                };
            };

            luasnip = {
                enable = true;
            };

            better-escape = {
                enable = true;
                mapping = ["jk" "kj"];
            };

            project-nvim = {
                enable = true;
            };

            telescope = {
                enable = true;
                extensions = {
                    file_browser = {
                        enable = true;
                        addDirs = false;
                        gitStatus = true;
                    };
                    media_files = {
                        enable = true;
                    };
                    project-nvim = {
                        enable = true;
                    };
                };
            };

            vimtex = {
                enable = true;
                texLivePackage = pkgs.texliveFull;
                viewMethod = "zathura";
            };

            trouble = {
                enable = true;
                icons = true;
                indentLines = true;
                useDiagnosticSigns = true;
            };

            nvim-autopairs = {
                enable = true;
                checkTs = true;
            };

            comment-nvim = {
                enable = true;
                mappings = {
                    basic = true;
                    extended = false;
                };
            };

            none-ls = {
                sources = {
                    formatting = {
                        stylua.enable = true;
                        nixfmt.enable = true;
                    };
                    diagnostics = {
                        deadnix.enable = true;
                        eslint.enable = true;
                    };
                };
            };

            noice = {
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

            gitsigns = {
                enable = true;

                signcolumn = true;
                trouble = true;
                numhl = false;
                linehl = false;
                wordDiff = false;
                currentLineBlame = true;
                currentLineBlameOpts = {
                    virtText = true;
                    virtTextPos = "right_align";
                    delay = 1000;
                    ignoreWhitespace = false;
                };

                signs = {
                    add = {
                        text = "│";
                    };
                    change = {
                        text = "│";
                    };
                    changedelete = {
                        text = "│";
                    };
                    delete = {
                        text = "│";
                    };
                    topdelete = {
                        text = "│";
                    };
                    untracked = {
                        text = "│";
                    };
                };
            };

            fidget = {
                enable = true;
                window = {
                    relative = "win";
                    blend = 0;
                    border = "single";
                };
                text = {
                    spinner = "moon";
                    done = "";
                    commenced = "Started";
                    completed = "Completed";
                };
                align = {
                    bottom = true;
                    right = true;
                };
                timer = {
                    spinnerRate = 125;
                    fidgetDecay = 2000;
                    taskDecay = 1000;
                };
            };

            diffview = {
                enable = true;
                enhancedDiffHl = true;
                useIcons = true;
            };

            fugitive = {
                enable = true;
            };

            treesitter = {
                enable = true;
                ensureInstalled = "all";
                folding = false;
                indent = true;
            };

            #TODO: inject CSS 
            markdown-preview = {
                enable = true;
            };

            rainbow-delimiters = {
                enable = true;
            };

            which-key = {
                enable = true;
            };

            todo-comments = {
                enable = true;
            };

            nvim-cmp = {
                enable = true;
                sources = [
                    { name = "nvim_lsp"; }
                    { name = "nvim_lua"; }
                    { name = "luasnip"; }
                    { name = "buffer"; }
                    { name = "path"; }
                    { name = "emoji"; }
                    { name = "crates"; }
                    { name = "dictionary"; }
                    { name = "calc"; }
                    { name = "fish"; }
                    { name = "digraphs"; }
                    { name = "spell"; }
                ];

                window = {
                    completion = {
                        border = "single";
                        #winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None";
                    };
                    documentation = {
                        border = "single";
                        #winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None";
                    };
                };

                mapping = {
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                    "<Tab>" = {
                        action = ''
                          function(fallback)
                            if cmp.visible() then
                              cmp.select_next_item()
                            elseif luasnip.expandable() then
                              luasnip.expand()
                            elseif luasnip.expand_or_jumpable() then
                              luasnip.expand_or_jump()
                            elseif check_backspace() then
                              fallback()
                            else
                              fallback()
                            end
                          end
                        '';
                        modes = [
                          "i"
                          "s"
                        ];
                    };
                };
            };

            cmp_luasnip = {
                enable = true;
            };
            cmp-path = {
                enable = true;
            };
            cmp-buffer = {
                enable = true;
            };
            cmp-calc = {
                enable = true;
            };
            cmp-cmdline = {
                enable = true;
            };
            cmp-dictionary = {
                enable = true;
            };
            cmp-digraphs = {
                enable = true;
            };
            cmp-emoji = {
                enable = true;
            };
            cmp-fish = {
                enable = true;
            };
            cmp-latex-symbols = {
                enable = true;
            };
            cmp-nvim-lsp-document-symbol = {
                enable = true;
            };
            cmp-nvim-lsp-signature-help = {
                enable = true;
            };

            cmp-nvim-lsp = {
                enable = true;
            };
            cmp-spell = {
                enable = true;
            };
            

            indent-blankline = {
                enable = true;

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

        # Define keymaps (will populate which-key)
        keymaps = [
            {
                action = "<cmd>LazyGitCurrentFile<CR>";
                key = "<leader>gg";
                mode = ["n"];
                options = {
                    desc = "LazyGit";
                };
            }
            {
                action = "<cmd>silent Git add %<CR>";
                key = "<leader>ga";
                mode = ["n"];
                options = {
                    desc = "Git Add File";
                };
            }
            {
                action = "<cmd>Git commit<CR>";
                key = "<leader>gc";
                mode = ["n"];
                options = {
                    desc = "Git Commit";
                };
            }
            {
                action = "<cmd>Git push<CR>";
                key = "<leader>gp";
                mode = ["n"];
                options = {
                    desc = "Git Commit";
                };
            }
            {
                action = "<cmd>Git blame<CR>";
                key = "<leader>gb";
                mode = ["n"];
                options = {
                    desc = "Git Blame";
                };
            }
            {
                action = "<cmd>Git log<CR>";
                key = "<leader>gl";
                mode = ["n"];
                options = {
                    desc = "Git Log";
                };
            }
            {
                action = "<cmd>G<CR>";
                key = "<leader>gs";
                mode = ["n"];
                options = {
                    desc = "Git Summary";
                };
            }
            {
                action = "<cmd>DiffviewOpen<CR>";
                key = "<leader>gd";
                mode = ["n"];
                options = {
                    desc = "Git Diff";
                };
            }
            {
                action = "<cmd>Telescope find_files<CR>";
                key = "<leader>ff";
                mode = ["n"];
                options = {
                    desc = "Find Files";
                };
            }
            {
                action = "<cmd>Telescope lsp_document_symbols<CR>";
                key = "<leader>fds";
                mode = ["n"];
                options = {
                    desc = "Find Document Symbols";
                };
            }
            {
                action = "<cmd>Telescope lsp_definitions<CR>";
                key = "<leader>fd";
                mode = ["n"];
                options = {
                    desc = "Find Definition";
                };
            }
            {
                action = "<cmd>Telescope lsp_implementations<CR>";
                key = "<leader>fi";
                mode = ["n"];
                options = {
                    desc = "Find Implementations";
                };
            }
            {
                action = "<cmd>TodoTelescope<CR>";
                key = "<leader>ft";
                mode = ["n"];
                options = {
                    desc = "Find Todos";
                };
            }
            {
                action = "<cmd>Telescope media_files<CR>";
                key = "<leader>fmf";
                mode = ["n"];
                options = {
                    desc = "Find Media Files";
                };
            }
            {
                action = "<cmd>Telescope man_pages<CR>";
                key = "<leader>fmp";
                mode = ["n"];
                options = {
                    desc = "Find Media Pages";
                };
            }
            {
                action = "<cmd>Telescope quickfix<CR>";
                key = "<leader>fqf";
                mode = ["n"];
                options = {
                    desc = "Find Quickfix";
                };
            }
            {
                action = "<cmd>Telescope lsp_references<CR>";
                key = "<leader>fr";
                mode = ["n"];
                options = {
                    desc = "Find References";
                };
            }
            {
                action = "<cmd>Telescope spell_suggest<CR>";
                key = "<leader>fs";
                mode = ["n"];
                options = {
                    desc = "Find Spelling Suggestions";
                };
            }
            {
                action = "<cmd>Telescope help_tags<CR>";
                key = "<leader>fvh";
                mode = ["n"];
                options = {
                    desc = "Find Vim Help";
                };
            }
            {
                action = "<cmd>Telescope commands<CR>";
                key = "<leader>fvc";
                mode = ["n"];
                options = {
                    desc = "Find Vim Commands";
                };
            }
            {
                action = "<cmd>Telescope keymaps<CR>";
                key = "<leader>fvk";
                mode = ["n"];
                options = {
                    desc = "Find Vim Keymaps";
                };
            }
            {
                action = "<cmd>Telescope live_grep<CR>";
                key = "<leader>fw";
                mode = ["n"];
                options = {
                    desc = "Find Word";
                };
            }
            {
                action = "<cmd>Telescope lsp_workspace_symbols<CR>";
                key = "<leader>fws";
                mode = ["n"];
                options = {
                    desc = "Find Workspace Symbols";
                };
            }
            {
                action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
                key = "<leader>lca";
                mode = ["n"];
                options = {
                    desc = "LSP Code Actions";
                };
            }
            {
                action = "<cmd>Telescope lsp_incoming_calls<CR>";
                key = "<leader>lic";
                mode = ["n"];
                options = {
                    desc = "LSP Incoming Calls";
                };
            }
            {
                action = "<cmd>Telescope lsp_outgoing_calls<CR>";
                key = "<leader>loc";
                mode = ["n"];
                options = {
                    desc = "LSP Outgoing Calls";
                };
            }
            {
                action = "<cmd>lua vim.lsp.buf.rename()<CR>";
                key = "<leader>lrn";
                mode = ["n"];
                options = {
                    desc = "LSP Rename";
                };
            }
            {
                action = "<cmd>lua vim.lsp.buf.hover()<CR>";
                key = "<leader>lci";
                mode = ["n"];
                options = {
                    desc = "LSP Cursor Info";
                };
            }
            {
                action = "<cmd>HopWord<CR>";
                key = "<leader>hw";
                mode = ["n"];
                options = {
                    desc = "Hop Word";
                };
            }
            {
                action = "<cmd>HopChar1<CR>";
                key = "<leader>hc";
                mode = ["n"];
                options = {
                    desc = "Hop Character";
                };
            }
            {
                action = "<cmd>HopLine<CR>";
                key = "<leader>hl";
                mode = ["n"];
                options = {
                    desc = "Hop Line";
                };
            }
            {
                action = "<cmd>MarkdownPreviewToggle<CR>";
                key = "<leader>mdp";
                mode = ["n"];
                options = {
                    desc = "Markdown Preview";
                };
            }
        ];

	};
}
