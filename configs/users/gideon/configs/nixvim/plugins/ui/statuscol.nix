{
  programs.nixvim.plugins.statuscol = {
    enable = true;
    settings = {
      clickhandlers = {
        FoldClose = "require('statuscol.builtin').foldclose_click";
        FoldOpen = "require('statuscol.builtin').foldopen_click";
        FoldOther = "require('statuscol.builtin').foldother_click";
        Lnum = "require('statuscol.builtin').lnum_click";
      };
      bt_ignore = [ "dashboard" ];
      relculright = true;
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
            name = [ "Diagnostic" ];
            maxwidth = 1;
            auto = true;
          };
          click = "v:lua.ScSa";
        }
        # Fold column
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
