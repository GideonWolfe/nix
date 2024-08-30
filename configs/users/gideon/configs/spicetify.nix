{ pkgs, config, spicetify-nix, ... }: 

with config.lib.stylix.colors;

{


  programs.spicetify =
    let spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      #theme = spicePkgs.themes.catppuccin;
      #colorScheme = "mocha";
      theme = spicePkgs.themes.sleek;
      colorScheme = "custom";
      customColorScheme = {
        "text"               = "${magenta}";
        "subtext"            = "${base05}";
        "nav-active-text"    = "${bright-green}";
        "main"               = "${base00}";
        "sidebar"            = "${base00}";
        "player"             = "${base00}";
        "card"               = "${base00}";
        "shadow"             = "${base02}";
        "main-secondary"     = "${base01}";
        "button"             = "${orange}";
        "button-secondary"   = "${bright-cyan}";
        "button-active"      = "${orange}";
        "button-disabled"    = "${base0D}";
        "nav-active"         = "${magenta}";
        "play-button"        = "${green}";
        "tab-active"         = "${yellow}";
        "notification"       = "${blue}";
        "notification-error" = "${red}";
        "playback-bar"       = "${bright-green}";
        "misc"               = "${bright-magenta}";
      };
    };

}
