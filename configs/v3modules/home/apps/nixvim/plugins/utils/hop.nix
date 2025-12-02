{ config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.nixvim.plugins.hop = { enable = true; };
  programs.nixvim.highlight = {
    HopNextKey = {
      fg = "${base08}";
      bold = true;
    };
    HopNextKey1 = {
      fg = "${base0D}";
      bold = true;
    };
    HopNextKey2 = {
      fg = "${base0A}";
      bold = true;
    };
    HopUnmatched = { fg = "${base04}"; };
    HopCursor = {
      fg = "${base0C}";
      bold = true;
    };
    HopPreview = {
      fg = "${base0E}";
      bold = true;
    };
  };
}
