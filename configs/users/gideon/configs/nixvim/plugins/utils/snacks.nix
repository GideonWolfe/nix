{ pkgs, ... }: {
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      bigfile = {
        enabled = true;
        notify = true;
      };
      notifier = {
        enabled = true;
        timeout = 3000;
        style = "compact";
      };
      quickfile = {
        enabled = false;
        exclude = [ "latex" ];
      };
      statuscolumn = { enabled = false; };
      dashboard = { enabled = true; };
      words = {
        debounce = 100;
        enabled = true;
      };
      #BUG: Snacks.picker.*() not found
      picker = {
        enabled = true;
      };
    };
  };
}
