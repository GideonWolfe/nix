{
  programs.nixvim.plugins.statuscol = {
    enable = true;
    settings = {
      # clickhandlers = {
      #   FoldClose = "require('statuscol.builtin').foldclose_click";
      #   FoldOpen = "require('statuscol.builtin').foldopen_click";
      #   FoldOther = "require('statuscol.builtin').foldother_click";
      #   Lnum = "require('statuscol.builtin').lnum_click";
      # };
      bt_ignore = [ "dashboard" ];

      # align line numbers to the right
      relculright = true;

      # display errors from a closed fold on the first line
      #BUG: not working on columns?
      # https://github.com/luukvbaal/statuscol.nvim/blob/1022f922b77b44c36f8057ac29adbfd89ce86958/README.md?plain=1#L118
      #foldclosed = true;

      segments = [

        # ScSa = Sign action
        # ScFa = Fold action
        # ScLa = LineNum action

        # Git signs (added/removed/changed)
        {
          sign = {
            namespace = [ "gitsign" ];
            maxwidth = 1;
            auto = true;
          };
          click = "v:lua.ScSa";
        }
        # Diagnostic signs
        {
          sign = {
            #name = [ "Diagnostic" ];
            #namespace = [ "diagnostic/signs" ];
            namespace = [ "diagnostic" ];
            maxwidth = 1;
            auto = true;
          };
          click = "v:lua.ScSa";
        }
        # Fold column
        # maybe set this rule?  https://github.com/luukvbaal/statuscol.nvim/issues/36
        {
          click = "v:lua.ScFa";
          text = [ { __raw = "require('statuscol.builtin').foldfunc"; } " " ];
        }
        # catch all for other items in status
        {
          sign = {
            name = [ ".*" ];
            maxwidth = 1;
            colwidth = 1;
            auto = true;
          };
          click = "v:lua.ScSa";
        }
        # Line numbers
        {
          click = "v:lua.ScLa";
          condition =
            [ true { __raw = "require('statuscol.builtin').not_empty"; } ];
          text = [ { __raw = "require('statuscol.builtin').lnumfunc"; } " " ];
        }
      ];
    };
  };
}
