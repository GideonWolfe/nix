{ config, pkgs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  inherit (config.nixvim) helpers;
in {

  programs.nixvim.extraConfigLua = ''

    function fmtMode()
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
  #
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options = {
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
        "lazy"
        "nvim-tree"
        "trouble"
        "symbols-outline"
        "nvim-dap-ui"
        "fugitive"
        "man"
      ];
    };

    #theme = "auto";

    # sections = { lualine_a = [ (helpers.mkRaw "fmtMode") ]; };
    # sections = { lualine_a.__raw = "{ fmtMode },"; };
    # sections = {
    #   lualine_a = {
    #     extraConfig = {
    #         #lualine_a.__raw = "fmtMode";
    #         __unkeyed-1.__raw = "fmtMode";
    #     };
    #     name.__raw = "fmtMode";
    #   };
    # };
  };
}
