{ config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.nixvim.plugins.rainbow-delimiters = { enable = true; };
  # Highlights
  programs.nixvim.highlight = {

    RainbowDelimiterRed = {
      bg = "${base00}";
      fg = "${base08}";
    };
    RainbowDelimiterYellow = {
      bg = "${base00}";
      fg = "${base0A}";
    };
    RainbowDelimiterBlue = {
      bg = "${base00}";
      fg = "${base0D}";
    };
    RainbowDelimiterOrange = {
      bg = "${base00}";
      fg = "${base09}";
    };
    RainbowDelimiterGreen = {
      bg = "${base00}";
      fg = "${base0B}";
    };
    RainbowDelimiterViolet = {
      bg = "${base00}";
      fg = "${base0E}";
    };
    RainbowDelimiterCyan = {
      bg = "${base00}";
      fg = "${base0C}";
    };
  };
}
