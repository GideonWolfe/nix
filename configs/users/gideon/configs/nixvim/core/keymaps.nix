{
  programs.nixvim.keymaps = [

    ## NAVIGATION
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

    # Editing
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

    # Git
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
            desc = "Git Push";
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
    
    # Navigates directly to definition in new tab
    {
        action = "<cmd>Telescope lsp_definitions<CR>";
        # Could also use Lspsaga goto_definition
        #action = "<cmd>Telescope lsp_definitions<CR>";
        key = "<leader>fd";
        mode = ["n"];
        options = {
            desc = "Find Definition";
        };
    }
    # Pops up a floating window showing the definition
    {
        action = "<cmd>Lspsaga peek_definition<CR>";
        key = "<leader>cd";
        mode = ["n"];
        options = {
            desc = "Code Definition";
        };
    }
    # Pops up a floating window showing the definition
    {
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        key = "<leader>cD";
        mode = ["n"];
        options = {
            desc = "Code Typedef";
        };
    }
    {
        action = "<cmd>Telescope lsp_implementations<CR>";
        #action = "<cmd>Lspsaga finder imp<CR>";
        key = "<leader>ci";
        mode = ["n"];
        options = {
            desc = "Code Implementations";
        };
    }
    {
        action = "<cmd>TodoTelescope<CR>";
        key = "<leader>cT";
        mode = ["n"];
        options = {
            desc = "Code Todos Telescope";
        };
    }
    {
        action = "<cmd>TodoTrouble<CR>";
        key = "<leader>ct";
        mode = ["n"];
        options = {
            desc = "Code Todos Trouble";
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
    # Pops up a floating window showing possible actions
    {
        #action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>ca";
        mode = ["n"];
        options = {
            desc = "Code Actions";
        };
    }
    # Pops up a floating window showing the diagnostics and possible actions
    {
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        key = "<leader>cd";
        mode = ["n"];
        options = {
            desc = "Code Diagnostics";
        };
    }
    # Pops up a floating window showing the diagnostics and possible actions
    {
        action = "<cmd>Lspsaga hover_doc<CR>";
        key = "K";
        mode = ["n"];
        options = {
            desc = "Code Hover Docs";
        };
    }
    # Pops up a pane on the right showing symbol outline
    {
        action = "<cmd>Lspsaga outline<CR>";
        key = "<leader>cs";
        mode = ["n"];
        options = {
            desc = "Code Symbols Outline";
        };
    }
    {
        #action = "<cmd>Telescope lsp_incoming_calls<CR>";
        action = "<cmd>Lspsaga incoming_calls<CR>";
        key = "<leader>ci";
        mode = ["n"];
        options = {
            desc = "Code Incoming Calls";
        };
    }
    {
        #action = "<cmd>Telescope lsp_outgoing_calls<CR>";
        action = "<cmd>Lspsaga outgoing_calls<CR>";
        key = "<leader>co";
        mode = ["n"];
        options = {
            desc = "Code Outgoing Calls";
        };
    }
    {
        #action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        action = "<cmd>Lspsaga lsp_rename ++project<CR>";
        key = "<leader>cr";
        mode = ["n"];
        options = {
            desc = "Code Rename";
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
}
