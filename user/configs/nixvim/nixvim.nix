{ pkgs, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

    imports = [
        ./plugins/treesitter.nix
        ./plugins/telescope.nix
        ./plugins/nvim-ufo.nix
        ./plugins/lsp.nix
        ./plugins/cmp.nix
    ];
	programs.nixvim = {

		# Enable NixVim configuration
		enable = true;

        enableMan = true;


        #TODO: do this a better way not hardcoded
        #colorscheme = lib.mkForce "catppuccin";
        colorschemes = {
            catppuccin = {
                enable = false;
                settings = {
                    flavour = "mocha";
                    integrations = {
                        indent_blankline = {
                            enabled = true;
                            colored_indent_levels = true;
                        };

                        cmp= true;
                        fidget= true;
                        markdown= true;
                        lsp_trouble= true;
                        native_lsp.enabled = true;
                        noice= true;
                        nvimtree= true;
                        rainbow_delimiters= true;

                    };
                };
            };
        };

        highlight = {

            #TODO: Use "link" option for the highlight defs that allows me to link HL groups to pre-existing ones to minimize overhead


            #Pmenu = {
            #    ctermfg = "${base05}";
            #    ctermbg = "${base00}";
            #};
            PmenuSel = {
                fg = "${base0B}";
                bg = "${base00}";
            };
            PmenuKind = {
                fg = "${base0D}";
            };
            PmenuKindSel = {
                fg = "${base0C}";
            };
            PmenuExtra = {
                fg = "${base05}";
            };
            PmenuExtraSel = {
                fg = "${base0B}";
            };
            PmenuSbar = {
                fg = "${base0B}";
            };
            PmenuThumb = {
                fg = "${base0D}";
                bg = "${base0C}";
            };

            FloatBorder = {
                fg = "${base0D}";
            };
            FloatBorderDark = {
                fg = "${base0A}";
            };

            Winseparator = {
                fg = "${base0D}";
            };
            
            Error = {
                fg = "${base08}";
                bold = true;
                italic = true;
            };
            Todo = {
                fg = "${base08}";
                bold = true;
            };

            IblScope = {
                fg = "${base08}";
            };

            TelescopeSelection = {
                fg = "${base0B}";
                bg = "${base00}";
                bold = true;
            };
            TelescopeSelectionCaret = {
                fg = "${base0E}";
                bg = "${base00}";
                bold = true;
            };
            TelescopeMultiSelection = {
                reverse = true;
            };
            TelescopeBorder = {
                fg = "${base0B}";
                bold = true;
            };
            TelescopePromptBorder = {
                fg = "${base0E}";
            };
            TelescopeResultsBorder = {
                fg = "${base08}";
            };
            TelescopePreviewBorder = {
                fg = "${base0A}";
            };
            TelescopeMatching = {
                fg = "${base0C}";
            };
            TelescopePromptPrefix = {
                fg = "${base08}";
            };

            HopNextKey = {
                fg = "${base08}";
                bold = true;
            };
            HopNextKey1 = {
                fg = "${base0D}";
                bold = true;
            };
            HopNextKey2 = {
                fg = "${base0A}";
                bold = true;
            };
            HopUnmatched = {
                fg = "${base01}";
            };
            HopCursor = {
                fg = "${base0C}";
                bold = true;
            };
            HopPreview = {
                fg = "${base0E}";
                bold = true;
            };

            # active line number
            CursorLineNr = {
                bg = "${base00}";
                fg = "${base0E}";
                bold = true;
            };

            # Colors for vim mode section
            lualine_a_insert = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_a_normal = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_a_command = {
                bg = "${base00}";
                fg = "${base0E}";
            };
            lualine_a_replace = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_a_visual = {
                bg = "${base00}";
                fg = "${base0C}";
            };
            lualine_a_terminal = {
                bg = "${base00}";
                fg = "${base0F}";
            };

            # Branch information
            lualine_b_insert = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_normal = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_command = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_replace = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_visual = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_terminal = {
                bg = "${base00}";
                fg = "${base0B}";
            };

            # Colors for Diagnostics
            lualine_b_diagnostics_error_normal = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diagnostics_warn_normal = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_b_diagnostics_info_normal = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_hint_normal = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_error_insert = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diagnostics_warn_insert = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_b_diagnostics_info_insert = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_hint_insert = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_error_visual = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diagnostics_warn_visual = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_b_diagnostics_info_visual = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_hint_visual = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_error_command = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diagnostics_warn_command = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_b_diagnostics_info_command = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_hint_command = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_error_replace = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diagnostics_warn_replace = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_b_diagnostics_info_replace = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diagnostics_hint_replace = {
                bg = "${base00}";
                fg = "${base0D}";
            };


            # Filename
            lualine_c_insert = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_c_normal = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_c_command = {
                bg = "${base00}";
                fg = "${base0E}";
            };
            lualine_c_replace = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_c_visual = {
                bg = "${base00}";
                fg = "${base0C}";
            };

            # Diffs
            lualine_b_diff_added_normal = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_diff_added_insert = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_diff_added_visual = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_diff_added_command = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_diff_added_replace = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_diff_added_terminal = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_b_diff_modified_normal = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diff_modified_insert = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diff_modified_visual = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diff_modified_command = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diff_modified_replace = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diff_modified_terminal = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_b_diff_removed_normal = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diff_removed_insert = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diff_removed_visual = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diff_removed_command = {
                bg = "${base00}";
                fg = "${base08}";
            };
            lualine_b_diff_removed_replace = {
                bg = "${base00}";
                fg = "${base08}";
            };

            # TODO: I don't think are doing anything
            lualine_x_filetype_DevIconLua_normal= {
                bg = "${base00}";
                fg = "${base0D}";
            };
            lualine_x_filetype_DevIconLua_insert= {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_x_filetype_DevIconLua_visual= {
                bg = "${base00}";
                fg = "${base0C}";
            };
            lualine_x_filetype_DevIconLua_replace= {
                bg = "${base00}";
                fg = "${base0A}";
            };
            lualine_x_filetype_DevIconLua_command= {
                bg = "${base00}";
                fg = "${base0E}";
            };


            # TODO: these aren't working
            # Separators

            lualine_transitional_lualine_a_normal_to_lualine_c_normal = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            lualine_transitional_lualine_a_normal_to_lualine_b_normal = {
                bg = "${base00}";
                fg = "${base0C}";
            };
            lualine_transitional_lualine_a_insert_to_lualine_b_insert = {
                bg = "${base00}";
                fg = "${base0E}";
            };
            lualine_transitional_lualine_b_normal_to_lualine_c_normal = {
                bg = "${base00}";
                fg = "${base0F}";
            };
            lualine_transitional_lualine_b_insert_to_lualine_c_normal = {
                bg = "${base00}";
                fg = "${base0F}";
            };

            # Rainbow delimiters
            RainbowDelimiterRed = {
                bg = "${base00}";
                fg = "${base08}";
            };
            RainbowDelimiterYellow = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            RainbowDelimiterBlue = {
                bg = "${base00}";
                fg = "${base0D}";
            };
            RainbowDelimiterOrange = {
                bg = "${base00}";
                fg = "${base09}";
            };
            RainbowDelimiterGreen = {
                bg = "${base00}";
                fg = "${base0B}";
            };
            RainbowDelimiterViolet = {
                bg = "${base00}";
                fg = "${base0E}";
            };
            RainbowDelimiterCyan = {
                bg = "${base00}";
                fg = "${base0C}";
            };

            NvimTreeGitDeleted = {
                bg = "${base00}";
                fg = "${base08}";
            };
            NvimTreeFileDirty = {
                bg = "${base00}";
                fg = "${base08}";
            };
            NvimTreeGitDirty = {
                bg = "${base00}";
                fg = "${base08}";
            };
            NvimTreeFolderNew = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            NvimTreeFileNew = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            NvimTreeFileMerge = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            NvimTreeGitMerge = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            NvimTreeGitNew = {
                bg = "${base00}";
                fg = "${base0A}";
            };
            NvimTreeSpecialFile = {
                bg = "${base00}";
                fg = "${base0E}";
                bold = true;
                underline = true;
            };


        };

        globals = {
            mapleader = " ";
        };

        clipboard.providers = {
            wl-copy = {
                enable = true;
            };
        };
        clipboard.register = "unnamedplus";

        autoCmd = [
            # resumes last place in file
            {
                event = "BufReadPost";
                callback = {
                    __raw = ''
                        function()
                            vim.cmd([[
                                if line("'\"") > 0 && line("'\"") <= line("$") |
                                    exe "normal! g`\"" |
                                endif
                            ]])
                        end
                    '';
                };

            }
        ];




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
        ];

        plugins = {

            bufferline = {

                enable = true;

                # Icons
                bufferCloseIcon = "";
                closeIcon = "";
                modifiedIcon = "";
                rightTruncMarker = "";
                separatorStyle = "thin";

                diagnostics = "nvim_lsp";

                diagnosticsIndicator = ''
                    function(count, level, diagnostics_dict, context)
                      local s = " "
                      for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " "
                          or (e == "warning" and " " or "" )
                        s = s .. n .. sym
                      end
                      return s
                    end
                '';

            };

            lspkind = {
                enable = true;
            };

            luasnip = {
                enable = true;
            };

            friendly-snippets = {
                enable = true;
            };

            nvim-tree = {
                enable = true;
            };

            better-escape = {
                enable = true;
                mapping = ["jk" "kj"];
            };

            project-nvim = {
                enableTelescope = true;
            };

            vimtex = {
                enable = true;
                texlivePackage = pkgs.texliveFull;
                settings = {
                    view_method = "zathura";
                };
            };

            trouble = {
                enable = true;
                settings = {
                    icons = true;
                    indent_lines = true;
                    use_diagnostic_signs = true;
                };
            };

            nvim-autopairs = {
                enable = true;
                settings = {
                    check_ts = true;
                };
            };

            surround = {
                enable = true;
            };

            hop = {
                enable = true;
            };

            comment = {
                enable = true;
                settings = {
                    mappings = {
                        basic = true;
                    };
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
                        #eslint.enable = true;
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

                settings = {

                    word_diff = false;
                    trouble = true;
                    linehl = false;
                    signcolumn = true;
                    numhl = false;
                    current_line_blame = true;
                    current_line_blame_opts = {
                        virt_text = true;
                        virt_text_pos = "right_align";
                        delay = 1000;
                        ignore_whitespace = false;
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

            };


            #TODO: Rewrite fidget config with new opts since plugin got rewritten 
            fidget = {
                enable = true;
            };

            diffview = {
                enable = true;
                enhancedDiffHl = true;
                useIcons = true;
            };

            fugitive = {
                enable = true;
            };

            lspsaga = {
                enable = true;
                # Breadcrumbs in top
                symbolInWinbar = {
                    enable = true;
                    colorMode = true;
                };
                # Shows code action
                lightbulb = {
                    enable = false;
                };
                # Shows details above function implementation
                implement = {
                    enable = true;
                };
                # Symbol outline sidebar
                outline = {
                    autoClose = true;
                };
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

            # TODO: advanced config required
            dap = {
                enable = true;
            };

            lualine = {
                enable = true;
                iconsEnabled = true;
                #theme = "auto";
                globalstatus = true;

                componentSeparators = {
                    #left = "╲";
                    #right = "╱";
                    left = ""; 
                    right = "";
                };

                sectionSeparators = {
                    left = "";
                    right = "";
                    #left = "";
                    #right = "";
                };
            };
            

            indent-blankline = {
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

            dashboard = {
                enable = true;



                settings = {

                    theme = "hyper";
                    
                    change_to_vcs_root = true;

                    config = {

                        # Most recently used
                        mru = {
                            icon_hl = "RainbowDelimiterBlue";
                        };

                        # TODO: i don't think this works with nix right
                        packages.enable = true;

                        project = {
                            enable = true;
                            icon = "";
                        };

                        header = [
                            "⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⢀⣠⣾⣷⣿⣿⣿⣶⣤⣿⣠⣶⡶⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠀⢀⣤⡶⣿⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣂⡶⣶⡐⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⢀⣀⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣽⣿⣿⣿⣿⣿⣿⣇⣤⣄⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⣰⣶⣿⣏⢿⡿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⢿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⣰⣿⣯⠉⠉⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣾⣷⣾⣿⣿⣿⣿⣽⣿⡇⠀⠀⠉⠉⣹⣧⡀⠀⠀⠀"
                            "⠀⠀⢀⣍⣿⡁⢀⡀⠀⠀⣿⠏⠀⠀⠉⠁⠀⠙⣿⣧⡋⡀⠀⠀⠀⠀⢉⣿⡀⠀⢀⠀⢹⣧⣅⠀⠀⠀"
                            "⢠⡄⠘⠻⢿⣷⣶⣤⣴⣿⣿⡀⣀⢠⣀⠀⣀⣬⣡⣄⡬⣀⢀⡀⠀⠀⢀⣿⢿⣦⣼⣶⣿⡿⠞⠀⣀⠀"
                            "⢸⡇⠀⣠⣼⣿⡟⠉⠛⣿⣾⣿⣮⣯⣥⡶⢿⣯⢛⡟⣴⡿⢶⣥⣤⣶⣿⣵⣿⠛⠛⠿⢿⣤⡀⠂⣉⠀"
                            "⠀⠁⣼⢟⡿⠋⠀⠀⠀⣠⣤⠀⠀⠀⠙⠛⢢⣧⠊⠉⣜⡔⠛⠃⠀⠀⠠⣤⡀⠀⠀⠀⠻⣿⠹⡆⠃⠀"
                            "⠀⠀⠈⡜⣧⠠⠤⢀⡴⣻⠄⢀⠠⡀⢀⣠⣷⠋⠀⠀⠘⢶⣄⡀⡄⠀⠀⢠⡝⣄⠀⡤⢀⡼⠀⠀⠀⠀"
                            "⠀⠀⢀⣿⣿⣿⣿⣿⣷⣿⣷⣼⣠⣜⣿⣾⠁⠀⠀⠀⠀⠀⣿⣯⣓⣛⣁⣼⣿⣾⣿⣿⣿⣤⣧⠀⠀⠀"
                            "⠀⢀⠘⡿⣿⣿⢿⣾⣿⣿⣏⠙⠻⣿⣿⣯⣀⢀⣠⢄⡀⢂⣿⣿⡿⠋⠉⢙⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀"
                            "⠀⠀⠀⠀⠈⢁⠈⠙⠉⠉⠉⢹⡆⡾⢸⣿⣿⠿⣿⣿⣿⣯⣍⠀⣡⢰⡏⠉⠉⠛⠉⠀⠉⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠘⣄⠀⠀⠀⠀⡾⡰⣿⣿⢿⡿⣦⣿⣽⢿⢻⡟⢳⣽⣎⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠈⠀⣸⡆⠀⠀⠉⢠⣦⣾⣀⣾⡇⠑⠀⠀⣤⡀⠉⣾⠀⠀⣸⡀⠀⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠀⠂⢸⣇⠀⠈⠲⠸⠏⣛⣫⣙⣃⣀⣀⣴⠋⣥⡔⠞⠁⠀⣿⠇⢪⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠀⢃⠘⠿⣴⠄⣤⡀⢃⠉⡝⣈⠛⠻⣉⢋⠀⣁⣰⢤⢰⣶⠟⠀⡏⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠀⠘⠆⠀⢹⣦⢠⡇⠙⣹⣧⡻⢼⠧⠟⣼⡿⠉⢹⢈⣼⡇⠀⠂⠁⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠳⣷⣷⣁⣺⣿⣿⣿⣤⣌⣻⣆⣾⡯⠿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠿⠿⠛⠛⠻⠿⠿⠟⠃⠀⠀⠀⠀          "
                        ];

                        footer = [
                            "you can't kill me in any way that matters"
                        ];
                        
                    };
                };
                
            };
        };

        # Define keymaps (will populate which-key)
        keymaps = [
            {
                action = "<C-w>k";
                key = "<C-k>";
                mode = ["n"];
                options = {
                    desc = "Switch window up";
                };
            }
            {
                action = "<C-w>j";
                key = "<C-j>";
                mode = ["n"];
                options = {
                    desc = "Switch window down";
                };
            }
            {
                action = "<C-w>l";
                key = "<C-l>";
                mode = ["n"];
                options = {
                    desc = "Switch window right";
                };
            }
            {
                action = "<C-w>l";
                key = "<C-l>";
                mode = ["n"];
                options = {
                    desc = "Switch window right";
                };
            }
            {
                action = "<C-w>h";
                key = "<C-h>";
                mode = ["n"];
                options = {
                    desc = "Switch window left";
                };
            }
            {
                action = ">>_";
                key = "<Tab>";
                mode = ["n"];
                options = {
                    desc = "Increase indent";
                };
            }
            {
                action = "<<_";
                key = "<S-Tab>";
                mode = ["n"];
                options = {
                    desc = "Decrease indent";
                };
            }
            {
                action = ":m .+1<CR>==";
                key = "<A-j>";
                mode = ["n"];
                options = {
                    desc = "Move line down";
                    silent = true;
                };
            }
            {
                action = ":m .-2<CR>==";
                key = "<A-k>";
                mode = ["n"];
                options = {
                    desc = "Move line up";
                    silent = true;
                };
            }
            {
                action = "<esc>:m .+1<CR>==";
                key = "<A-j>";
                mode = ["i"];
                options = {
                    desc = "Move line down";
                    silent = true;
                };
            }
            {
                action = "<esc>:m .-2<CR>==";
                key = "<A-v>";
                mode = ["i"];
                options = {
                    desc = "Move line up";
                    silent = true;
                };
            }
            {
                action = ":m '>+1<CR>gv=gv";
                key = "<A-j>";
                mode = ["v"];
                options = {
                    desc = "Move line down";
                    silent = true;
                };
            }
            {
                action = "<esc>:m '<-2<CR>gv=gv";
                key = "<A-k>";
                mode = ["i"];
                options = {
                    desc = "Move line up";
                    silent = true;
                };
            }
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
            {
                action = "<cmd>NvimTreeToggle<CR>";
                key = "<leader>nt";
                mode = ["n"];
                options = {
                    desc = "Nvim Tree";
                };
            }
            {
                action = "<Plug>(dial-increment)";
                key = "<C-a>";
                mode = ["n" "v"];
                options = {
                    desc = "Dial increment";
                };
            }
            {
                action = "<Plug>(dial-decrement)";
                key = "<C-x>";
                mode = ["n" "v"];
                options = {
                    desc = "Dial increment";
                };
            }
        ];

	};
}
