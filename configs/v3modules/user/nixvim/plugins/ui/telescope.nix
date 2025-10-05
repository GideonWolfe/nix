{ config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  # Main Telescope plugin
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file-browser = {
        enable = false; # try disabling to speedup startup
        settings = {
          add_dirs = false;
          git_status = true;
        };
      };
      media-files = {
        #INFO: this kills startuptime
        enable = false;
      };
    };
  };

  programs.nixvim.highlight = {
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
    TelescopeMultiSelection = { reverse = true; };
    TelescopeBorder = {
      fg = "${base0B}";
      bold = true;
    };
    TelescopePromptBorder = { fg = "${base0E}"; };
    TelescopeResultsBorder = { fg = "${base08}"; };
    TelescopePreviewBorder = { fg = "${base0A}"; };
    TelescopeMatching = { fg = "${base0C}"; };
    TelescopePromptPrefix = { fg = "${base08}"; };
  };
}
