{ config, ... }:

with config.lib.stylix.colors.withHashtag; {
  programs.nixvim.plugins.dap = {
    enable = true;
    # BUG: these aren't working
    signs = {
      dapBreakpoint = {
        text = "•";
        texthl = "BreakpointLineNr";
        linehl = "";
        numhl = "BreakpointLineNr";
      };
      dapBreakpointCondition = {
        text = "";
        texthl = "Yellow";
        linehl = "";
        numhl = "Yellow";
      };
      dapBreakpointRejected = {
        text = "";
        texthl = "Orange";
        linehl = "";
        numhl = "Orange";
      };
      dapLogPoint = {
        text = "";
        texthl = "Blue";
        linehl = "";
        numhl = "Blue";
      };
      dapStopped = {
        text = "";
        texthl = "Red";
        linehl = "";
        numhl = "Red";
      };
    };
  };
}
