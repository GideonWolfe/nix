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

            comment-nvim = {
                enable = true;
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

            treesitter = {
                enable = true;
                ensureInstalled = "all";
                folding = false;
                indent = true;
            };


            rainbow-delimiters = {
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

	};
}
