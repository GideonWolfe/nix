{ config, pkgs, ... }:
with config.lib.stylix.colors.withHashtag;
let inherit (config.nixvim) helpers;
in {

  #
  programs.nixvim.plugins.lualine = {
    enable = true;

    #BUG: how to get this to apply??
    luaConfig = {
      pre = ''
        local colors = {
          black        = '${base00}',
          white        = '${base05}',
          red          = '${base08}',
          green        = '${base0B}',
          blue         = '${base0D}',
          yellow       = '${base0A}',
          gray         = '${base04}',
          darkgray     = '${base01}',
          lightgray    = '${base05}',
          inactivegray = '${base04}',
        }
        local lualine_stylix_theme =  {
          normal = {
            a = {bg = colors.gray, fg = colors.black, gui = 'bold'},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.darkgray, fg = colors.gray}
          },
          insert = {
            a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.lightgray, fg = colors.white}
          },
          visual = {
            a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.inactivegray, fg = colors.black}
          },
          replace = {
            a = {bg = colors.red, fg = colors.black, gui = 'bold'},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.black, fg = colors.white}
          },
          command = {
            a = {bg = colors.green, fg = colors.black, gui = 'bold'},
            b = {bg = colors.lightgray, fg = colors.white},
            c = {bg = colors.inactivegray, fg = colors.black}
          },
          inactive = {
            a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
            b = {bg = colors.darkgray, fg = colors.gray},
            c = {bg = colors.darkgray, fg = colors.gray}
          }
        }
      '';
    };

    settings = {

      sections = {
        lualine_a = [
          "name"
          {
            __unkeyed-1 = {
              __raw = ''
                function()
                    local mode = vim.api.nvim_get_mode()["mode"]
                    if mode == "n" then
                        return ''
                    elseif mode == "i" then
                        return ''
                    elseif mode == "v" then
                        return ''
                    elseif mode == "V" then
                        return ''
                    elseif mode == "\22" then -- wierd encodings for ctrl + v
                        return ''
                    elseif mode == "c" then
                        return ''
                    elseif mode == "R" then
                        return ''
                    -- else
                    --  return '?'
                    end
                end
              '';
            };
          }
        ];
      };
      options = {

        #theme = "lualine_stylix_theme";

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
          left = "";
          right = "";
        };

        section_separators = {
          left = "";
          right = "";
          #left = "";
          #right = "";
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
