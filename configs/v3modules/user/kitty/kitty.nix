{ pkgs, lib, osConfig, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.kitty = {
    enable = true;

    enableGitIntegration = true;

    settings = {
      window_padding_width = 4;
      cursor_trail = 1;
    };

    keybindings = { "ctrl+shift+n" = "new_os_window_with_cwd"; };

    # https://sw.kovidgoyal.net/kitty/shell-integration/
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    extraConfig = ''
      function iplot {
          cat <<EOF | gnuplot
          set terminal pngcairo enhanced font '${osConfig.stylix.fonts.monospace.name},${
            builtins.toString osConfig.stylix.fonts.sizes.desktop
          }'
          set autoscale
          set samples 1000
          set output '|kitten icat --stdin yes'
          set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
          plot $@
          set output '/dev/null'
      EOF
      }
    '';
  };
}
