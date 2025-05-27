{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag; {
  programs.nixvim.plugins.bufferline = {
    enable = true;

    settings = {
      options = {
        buffer_close_icon = "";
        close_icon = "";
        modified_icon = "%#Orange#";
        right_trunc_marker = "";
        separator_style = "thin";
        #indicator.style = "underline";
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
      # highlights = {
      #   background = { bg = "${base01}"; };
      #   #diagnostic = { bg = "${base01}"; };
      #   fill = { bg = "${base01}"; };
      # };
    };
  };
}
