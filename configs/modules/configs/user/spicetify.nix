{ pkgs, config, inputs, ... }:

with config.lib.stylix.colors;

{

  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      # https://github.com/Gerg-L/spicetify-nix/blob/master/docs/EXTENSIONS.md
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
        songStats
      ];
      #theme = spicePkgs.themes.catppuccin;
      #colorScheme = "mocha";
      theme = spicePkgs.themes.sleek;
      colorScheme = "custom";
      customColorScheme = {
        "text" = "${magenta}";
        "subtext" = "${base05}";
        "nav-active-text" = "${bright-green}";
        "main" = "${base00}";
        "sidebar" = "${base00}";
        "player" = "${base00}";
        "card" = "${base00}";
        "shadow" = "${base02}";
        "main-secondary" = "${base01}";
        "button" = "${orange}";
        "button-secondary" = "${bright-cyan}";
        "button-active" = "${orange}";
        "button-disabled" = "${base0D}";
        "nav-active" = "${magenta}";
        "play-button" = "${green}";
        "tab-active" = "${yellow}";
        "notification" = "${blue}";
        "notification-error" = "${red}";
        "playback-bar" = "${bright-green}";
        "misc" = "${bright-magenta}";
      };
    };
}
