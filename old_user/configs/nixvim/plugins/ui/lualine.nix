{
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
  };
}
