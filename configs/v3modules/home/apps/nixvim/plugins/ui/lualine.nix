{ config, pkgs, ... }:
with config.lib.stylix.colors.withHashtag;
let inherit (config.nixvim) helpers;
in {

  #
  programs.nixvim.plugins.lualine = {
    enable = true;

    #BUG: how to get this to apply??
    #luaConfig = { pre = ; };

    settings = {

      sections = {
        # Vim Mode
        lualine_a = [{
          __unkeyed-1 = {
            __raw = ''
              function()
                  local mode = vim.api.nvim_get_mode()["mode"]
                  if mode == "n" then
                      return '%#Blue#'
                  elseif mode == "i" then
                      return '%#Green#'
                  elseif mode == "v" then
                      return '%#Yellow#'
                  elseif mode == "V" then
                      return '%#Orange#'
                  elseif mode == "\22" then -- wierd encodings for ctrl + v
                      return '%#Cyan#'
                  elseif mode == "c" then
                      return '%#Magenta#'
                  elseif mode == "R" then
                      return '#Brown#'
                  -- else
                  --  return '?'
                  end
              end
            '';
          };
        }];
        lualine_b = [
          # Current branch
          {
            __unkeyed = "branch";
            icon = {
              __unkeyed = "";
              color = { fg = "${green}"; };
            };
          }
          # Set custom diff options
          {
            __unkeyed = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
          }
          "diagnostics"
        ];
        lualine_c = [
          # Set custom filename options
          {
            __unkeyed = "filename";
            file_status = true;
            newfile_status = true;
            path = 1;
            symbols = {
              modified = "%#Orange# ";
              readonly = "%#Red# ";
              unnamed = "%#Yellow#"; # BUG: this specific one doesn't work
              newfile = "%#Blue# ";
            };

          }
        ];

        lualine_x = [
          "encoding"
          # Set custom filename options
          {
            __unkeyed = "fileformat";
            symbols = {
              unix = "%#Orange#";
              dos = "%#Blue#";
              mac = "%#Red#";
            };
          }
          {
            __unkeyed = "filetype";
            icon_only = true;
            icon = { align = "right"; };
          }
        ];
        lualine_y = [ "" ];
        lualine_z = [ "" ];
      };
      options = {

        #theme = "lualine_stylix_theme";
        #theme = { normal.a.bg = "${base00}"; };
        theme = {
          normal = {
            a = {
              bg = "${base00}";
              # no foreground because symbol changes color
            };
            b = {
              bg = "${base00}";
              fg = "${base05}";
            };
            c = {
              bg = "${base00}";
              # no foreground bc symbols/numbers change color
            };
          };

        };

        disabled_filetypes = {
          winbar = [
            "toggleterm"
            "Trouble"
            "dapui_scopes"
            "dapui_breakpoints"
            "dapui_watchs"
            "dapui_repl"
            "dapui_console"
          ];
          statusline = [ "sagaoutline" ];
        };

        globalstatus = true;
        icons_enabled = true;

        component_separators = {
          #left = "╲";
          #right = "╱";
          left = "%#Blue#";
          right = "%#Blue#";
        };

        section_separators = {
          #left = "";
          #right = "";
          #left = "";
          #right = "";
          left = "%#Orange#";
          right = "%#Orange#";
        };
      };
      extensions = [
        "nvim-tree"
        "trouble"
        "symbols-outline"
        "nvim-dap-ui"
        "fugitive"
        "man"
      ];
    };
  };
}
