{ config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.nixvim.plugins.gitsigns = {

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
        add = { text = "│"; };
        change = { text = "│"; };
        changedelete = { text = "│"; };
        delete = { text = "│"; };
        topdelete = { text = "│"; };
        untracked = { text = "│"; };
      };
    };

  };

  programs.nixvim.highlightOverride = {
    GitSignsAdd = {
      bg = "${base00}";
      fg = "${green}";
    };
    GitSignsChange = {
      bg = "${base00}";
      fg = "${magenta}";
    };
    GitSignsDelete = {
      bg = "${base00}";
      fg = "${red}";
    };
    GitSignsUntracked = {
      bg = "${base00}";
      fg = "${blue}";
    };
  };
}
