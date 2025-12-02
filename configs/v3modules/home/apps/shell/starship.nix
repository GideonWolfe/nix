{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    # I have a custom prompt for Fish
    enableFishIntegration = false;
  };
}
