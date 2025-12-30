{ pkgs, ... }:
{
  programs.nixvim.plugins.vimtex = {
    enable = true;
    #texlivePackage = pkgs.texliveFull;
    texlivePackage = pkgs.texliveMinimal;
    settings = {
        view_method = "zathura";
    };
  };
}
