{ config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.nixvim.plugins.nvim-tree = { enable = true; };
  programs.nixvim.highlight = {
    NvimTreeGitDeleted = {
      bg = "${base00}";
      fg = "${base08}";
    };
    NvimTreeFileDirty = {
      bg = "${base00}";
      fg = "${base08}";
    };
    NvimTreeGitDirty = {
      bg = "${base00}";
      fg = "${base08}";
    };
    NvimTreeFolderNew = {
      bg = "${base00}";
      fg = "${base0A}";
    };
    NvimTreeFileNew = {
      bg = "${base00}";
      fg = "${base0A}";
    };
    NvimTreeFileMerge = {
      bg = "${base00}";
      fg = "${base0A}";
    };
    NvimTreeGitMerge = {
      bg = "${base00}";
      fg = "${base0A}";
    };
    NvimTreeGitNew = {
      bg = "${base00}";
      fg = "${base0A}";
    };
    NvimTreeSpecialFile = {
      bg = "${base00}";
      fg = "${base0E}";
      bold = true;
      underline = true;
    };
  };
}
