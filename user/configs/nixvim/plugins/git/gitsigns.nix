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
}
