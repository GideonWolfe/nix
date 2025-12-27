{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.khard = {
      enable = true;
  };
}
