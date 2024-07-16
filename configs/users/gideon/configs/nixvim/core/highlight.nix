{ pkgs, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
    programs.nixvim.highlight = {

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
                fg = "${base04}";
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
            DashboardHeader = {
                bg = "${base00}";
                fg = "${base0E}";
            };
    };
}
