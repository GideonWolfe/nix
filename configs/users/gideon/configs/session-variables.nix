{ pkgs, lib, config, ... }:
# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. If you don't want to manage your shell through Home
# Manager then you have to manually source 'hm-session-vars.sh' located at
# either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/gideon/etc/profile.d/hm-session-vars.sh
#
{
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "kitty";
    BROWSER = "firefox";
    PAGER = "ov";
    #RULES =
    #  "${config.home.homeDirectory}/nix/configs/users/gideon/secrets/secrets.nix";
    RULES = "${config.home.homeDirectory}/nix/configs/secrets/secrets.nix";
    XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";

    # Optional, hint Electron apps to use Wayland:
    NIXOS_OZONE_WL = "1";

  };
}
