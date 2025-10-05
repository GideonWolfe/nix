{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.bash = {
    enable = true;
  };
}
