{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      default_shell = "fish";
      mouse_mode = true;
      copy_command = "wl-copy";
      scrollback_editor = "${lib.getExe pkgs.neovim}";

      # keybinds = {
      #           normal = {};
      #       };

      theme = "stylix";
      themes = {
        stylix = {
          fg = "${base05}";
          bg = "${base00}";
          black = "${base00}";
          red = "${base08}";
          green = "${base0B}";
          yellow = "${base0A}";
          blue = "${base0D}";
          magenta = "${base0E}";
          cyan = "${base0C}";
          white = "${base05}";
          orange = "${base09}";
        };
      };
    };
  };
}
