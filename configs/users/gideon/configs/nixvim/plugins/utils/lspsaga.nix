{
  programs.nixvim.plugins.lspsaga = {

    enable = true;
    # Breadcrumbs in top
    symbolInWinbar = {
        enable = true;
        colorMode = true;
        hideKeyword = true;
        folderLevel = 2;
        showFile = false;
    };
    # Shows code action
    lightbulb = {
        enable = false;
    };
    # Shows details above function implementation
    implement = {
        enable = true;
    };
    # Symbol outline sidebar
    outline = {
        autoClose = true;
    };
  };
}
