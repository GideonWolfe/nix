{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  services.mako = {
    # disabling because ags does it
    enable = false;
    icons = true;
    textColor = base05;
    defaultTimeout = 10000; # 10 secs
    extraConfig = ''
      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
