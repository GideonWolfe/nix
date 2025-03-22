{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}
