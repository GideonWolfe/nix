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

  programs.nixvim.plugins.lualine = {
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

    # sections = { lualine_a = [ (helpers.mkRaw "fmtMode") ]; };
    sections = { lualine_a.__raw = "{ fmtMode },"; };

  };
}
