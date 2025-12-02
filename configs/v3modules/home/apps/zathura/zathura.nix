{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.zathura = {
    enable = true;

    options = {
      recolor = true;
      default-fg = lib.mkForce "${base05}"; # stylix sets this to a yucky color
    };
  };
}
