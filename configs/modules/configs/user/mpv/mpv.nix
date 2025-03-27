{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
    config = {
      background-color = "${base00}";
      osd-back-color = "${base01}";
      osd-border-color = "${base0E}";
      osd-color = "${base05}";
      osd-shadow-color = "${base00}";
    };
  };
}
