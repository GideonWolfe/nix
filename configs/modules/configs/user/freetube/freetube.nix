{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.freetube = {
    enable = true;
    settings = {
      checkForUpdates = false;
      defaultQuality = "1080";
    };
  };
}
