{ pkgs, lib, config, ... }:

{
  programs.thunderbird = {

    enable = true;
    profiles = {
      gideon = {
        isDefault = true;
      };
    };
  };
}
