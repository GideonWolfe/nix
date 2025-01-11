{
  programs.nixvim.plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        buffer_close_icon = "";
        close_icon = "";
        modified_icon = "";
        right_trunc_marker = "";
        separator_style = "thin";
        diagnostics = "nvim_lsp";

        diagnostics_indicator = ''
          function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " "
                or (e == "warning" and " " or "󰌶 " )
              s = s .. n .. sym
            end
            return s
          end
        '';
      };
    };
  };
}
