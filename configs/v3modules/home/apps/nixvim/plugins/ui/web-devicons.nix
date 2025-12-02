{ config, ... }:
with config.lib.stylix.colors.withHashtag; {
  # Enable the devicons
  programs.nixvim.plugins.web-devicons = { enable = true; };
  # Enable automatching of colors to my theme
  # BUG: this doesn't seem to be working, ie. HTML and CSV files have ugly colors
  # works if I run the lua code require("tiny-devicons-auto-colors").apply(colors_table)
  programs.nixvim.plugins.tiny-devicons-auto-colors = {
    enable = true;
    autoLoad = true;
    settings = {
      colors = [
        "${base05}"
        "${base06}"
        "${base07}"
        "${base08}"
        "${base09}"
        "${base0A}"
        "${base0B}"
        "${base0C}"
        "${base0D}"
        "${base0E}"
        "${base0F}"
      ];
    };
    # BUG: Uncommenting this breaks nix build?? fails to connect to daemon
    # luaConfig.post = ''
    #   require("tiny-devicons-auto-colors").apply(colors_table)
    # '';
  };
}
