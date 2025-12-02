{ pkgs, ... }:
{
  programs.nixvim.plugins.vimtex = {
    enable = true;
    texlivePackage = pkgs.texliveFull;
    settings = {
        view_method = "zathura";
    };
  };
}
