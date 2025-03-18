{
  programs.nixvim.opts = {
    # Enable mouse
    mouse = "a";

    # Disable swap
    swapfile = false;
    # Enable undofile
    undofile = true;

    # Autocomplete options
    completeopt = "menuone,noinsert,noselect";

    # Highlight search results
    hlsearch = true;
    incsearch = true;
    ignorecase = true;
    smartcase = true;

    # wait time for key sequences
    timeoutlen = 500;
    # faster completion
    updatetime = 300;

    # Enable spellcheck
    spell = true;

    list = false;

    # Set line numbers
    number = true;
    relativenumber = true;
    numberwidth = 2;

    signcolumn = "yes";

    # Show matching parens
    showmatch = true;

    # 1 means flat, >1 means nested folds
    foldcolumn = "1";
    #foldcolumn = "auto:9";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;

    # splits
    splitright = true;
    splitbelow = true;

    linebreak = true;
    wrap = true;

    laststatus = 3;
    cmdheight = 2;

    showmode = false;

    scrolloff = 3;
    sidescrolloff = 5;

    conceallevel = 0;

    cursorline = true;

    pumheight = 10;

    showtabline = 2;

    # Tabs and indents
    # use spaces instead of tabs
    expandtab = true;
    # shift 4 spaces when tabbed
    tabstop = 4;
    shiftwidth = 4;
    # autoindent new lines
    smartindent = true;

    # memory and cpu
    # enable background buffers
    hidden = true;
    # remember N lines in history
    history = 100;

    fillchars = {
      fold = "─";
      foldopen = "";
      foldclose = "";
      diff = "╱";
      wbr = "─";
      msgsep = "─";
      horiz = "─";
      horizup = "│";
      horizdown = "│";
      vertright = "│";
      vertleft = "│";
      verthoriz = "│";
    };
  };
}
