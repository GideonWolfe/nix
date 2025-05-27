{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{

  programs.nixvim.highlight = {

    #TODO: Use "link" option for the highlight defs that allows me to link HL groups to pre-existing ones to minimize overhead

    # some custom groups just to access foreground colors 
    Red = {
      fg = "${base08}";
      bg = "${base00}";
    };
    Orange = {
      fg = "${base09}";
      bg = "${base00}";
    };
    Yellow = {
      fg = "${base0A}";
      bg = "${base00}";
    };
    Green = {
      fg = "${base0B}";
      bg = "${base00}";
    };
    Cyan = {
      fg = "${base0C}";
      bg = "${base00}";
    };
    Blue = {
      fg = "${base0D}";
      bg = "${base00}";
    };
    Magenta = {
      fg = "${base0E}";
      bg = "${base00}";
    };
    Brown = {
      fg = "${base0E}";
      bg = "${base00}";
    };

    FloatBorder = { fg = "${base0D}"; };
    FloatBorderDark = { fg = "${base0A}"; };

    StatusLine = { fg = "${base0E}"; };

    Error = {
      fg = "${base08}";
      bold = true;
      italic = true;
    };
    Todo = {
      fg = "${base08}";
      bold = true;
    };

    IblScope = { fg = "${base08}"; };

    # color of fold line
    FoldColumn = {
      bg = "${base00}";
      fg = "${base04}";
    };

    # Custom hl group to highlight line number where breakpoint is set
    BreakpointLineNr = {
      bg = "${base00}";
      fg = "${red}";
      bold = true;
    };

    DashboardHeader = {
      bg = "${base00}";
      fg = "${base0E}";
    };

  };

  # HACK:
  # Some highlight groups get overidden 
  # so we override them back here
  programs.nixvim.highlightOverride = {
    # active line number
    CursorLineNr = {
      fg = "${base0E}";
      bold = true;
    };
    CursorLineColumn = {
      fg = "none";
      bg = "${base00}";
    };
    CursorLine = {
      fg = "none";
      bg = "none";
    };
    LineNr = {
      fg = "none";
      bg = "${base00}";
    };
    LineNrAbove = {
      fg = "${base04}";
      bg = "${base00}";
    };
    LineNrBelow = {
      fg = "${base04}";
      bg = "${base00}";
    };
    # Status Column fold line
    FoldColumn = {
      bg = "${base00}";
      fg = "${base04}";
    };
    CursorLineFold = {
      bg = "${base00}";
      fg = "${base04}";
    };
    SignColumn = {
      bg = "${base00}";
      fg = "${base04}";
    };
    # Line split between windows
    WinSeparator = { fg = "${base0E}"; };
    # what does this do
    WinBar = { fg = "${base0D}"; };
    WinBarNC = { fg = "${base0D}"; };
    # BG when no sign
    CursorLineSign = { bg = "${base00}"; };

    # Current Pmenu selection
    PmenuSel = {
      fg = "${base0B}";
      bg = "${base01}";
    };
    PmenuKind = { fg = "${base0D}"; };
    PmenuKindSel = { fg = "${base0C}"; };
    PmenuExtra = { fg = "${base05}"; };
    PmenuExtraSel = { fg = "${base0B}"; };
    PmenuSbar = { fg = "${base0B}"; };
    PmenuThumb = {
      fg = "${base0D}";
      bg = "${base0E}";
    };
    BufferLineCloseButtonSelected = {
      fg = "${base08}";
      bold = true;
    };
    BufferLineCloseButtonVisible = { fg = "${base08}"; };
    BufferLineCloseButton = { fg = "${base08}"; };
  };
}
