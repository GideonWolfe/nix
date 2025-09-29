{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  # CLI for github
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
    };
    extensions = with pkgs;
      [
        gh-s # search repositories
      ];
  };

  # dashboard for GH
  programs.gh-dash = { enable = true; };
}
