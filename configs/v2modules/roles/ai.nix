{ config, lib, pkgs, ... }:

{
  options.ai = {
    enable = lib.mkEnableOption "AI tools and services";
  };

  config = lib.mkIf config.ai.enable {
    # Enable LocalAI by default when ai role is enabled
    ai.localai.enable = lib.mkDefault true;

    # Enable mods for all normal users on the system
    home-manager.users = lib.genAttrs 
      (lib.attrNames (lib.filterAttrs (name: user: user.isNormalUser) config.users.users))
      (user: {
        mods.enable = lib.mkDefault true;
      });
  };
}
