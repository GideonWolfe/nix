{
  programs.nixvim.plugins.better-escape = {
    enable = true;
    settings = {
      mappings = {
        # insert mode
        i = {
          j = { k = "<Esc>"; };
          k = { j = "<Esc>"; };
        };
      };
    };
  };
}
