{
  programs.nixvim.plugins.lspsaga = {

    enable = true;
    settings = {
      # Breadcrumbs in top
      symbol_in_winbar = {
        enable = true;
        color_mode = true;
        hide_keyword = true;
        folder_level = 2;
        show_file = false;
        separator = " %#Orange#› ";
      };
      # Shows code action
      lightbulb = { enable = false; };
      # Shows details above function implementation
      implement = { enable = true; };
      # Symbol outline sidebar
      outline = { auto_close = true; };
    };


    };
}
