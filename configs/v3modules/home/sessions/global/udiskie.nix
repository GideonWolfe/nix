{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  services.udiskie = {
      enable = true;

      };
}
