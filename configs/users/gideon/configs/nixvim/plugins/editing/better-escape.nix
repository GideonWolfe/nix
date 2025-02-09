{
  programs.nixvim.plugins.better-escape = {
    enable = true;
    #settings = { mapping = [ "jk" "kj" ]; };
    settings = {
      mappings = {
        # insert mode
        i = {
          j = { k = "<Esc>"; };
          k = { j = "<Esc>"; };
        };
        # visual mode
        v = {
          j = { k = "<Esc>"; };
          k = { j = "<Esc>"; };
        };
      };
    };
  };
}
